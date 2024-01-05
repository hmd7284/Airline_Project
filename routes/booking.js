const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/flight_search");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/home");
}

async function fetchAirportsFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT airport_code,address FROM airport",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

async function SearchResults(
  origin,
  destination,
  departureDate,
  numberOfTickets,
) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT f.flight_code, f.departure_date, f.departure_time, r.origin, r.destination, a.aircraft_code, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
      [origin, destination, departureDate, numberOfTickets],
    );
    console.log(result.rows);
    return result.rows;
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
}

router.get("/flight_search", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const { origin, destination, departureDate, numberOfTickets } = req.query;
    console.log(req.query);
    req.session.userInput = req.query;
    const userInput = req.session.userInput || {};
    if (origin && destination && departureDate && numberOfTickets) {
      if (origin === destination) {
        req.flash("errors", "Origin and destination cannot be the same!");
        res.render("user_booking.ejs", {
          airports,
          results: [], // or any other default value
          userInput,
          scrollToResults: false,
        });
        return;
      }
      const results = await SearchResults(
        origin,
        destination,
        departureDate,
        numberOfTickets,
      );
      console.log(results);
      res.render("user_booking.ejs", {
        airports,
        results,
        userInput,
        scrollToResults: true,
      });
    }
    res.render("user_booking.ejs", {
      airports,
      userInput,
      scrollToResults: false,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_booking", isLoggedIn, (req, res) => {
  res.render("user_booking.ejs", {
    section: "booking",
    messages: req.flash("errors"),
  });
});

router.post("/flight_booking", isLoggedIn, async (req, res) => {
  const { flight_code, type, quantity } = req.body;
  const client = await db.connect();
  try {
    await client.query("BEGIN");
    const flight_query = await client.query(
      "SELECT business_seat, economy_seat FROM flight_schedule WHERE flight_code = $1",
      [flight_code],
    );
    if (flight_query.rows.length === 0) {
      req.flash(
        "errors",
        "Flight not found! Make sure you enter the correct flight code.",
      );
      res.redirect("/flight_results");
      return;
    }
    const flight = flight_query.rows[0];
    if (type === "Business" && flight.business_seat < quantity) {
      req.flash("errors", "Not enough business seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (type === "Economy" && flight.economy_seat < quantity) {
      req.flash("errors", "Not enough economy seats available!");
      res.redirect("/flight_booking");
      return;
    }
    const transactionResult = await client.query(
      "INSERT INTO transactions (booking_date, customer_id, discount, total_amount) VALUES (current_date, $1, $2, $3) RETURNING transaction_id",
      [req.session.userId, discount_code, 0],
    );
    const transactionId = transactionResult.rows[0].transaction_id;
    const orderResult = await client.query(
      "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4)",
      [transactionId, flight_code, type, quantity],
    );
    if (orderResult.rows.length > 0) {
      req.flash("sucess", "Successfully booked flight!");
      res.redirect("/confirmation");
    } else {
      console.error("Error during booking:", error);
      req.flash("errors", "Error during booking");
      res.redirect("/flight_results");
    }
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
});

module.exports = router;
