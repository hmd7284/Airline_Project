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
      "SELECT * FROM airport",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/flight_search", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    res.render("flight_page.ejs", {
      airports,
      section: "search",
      messages: req.flash("errors"),
    });
  } catch (error) {
    req.flash("errors", "Error fetching airport data");
    console.error("Error fetching airport data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post("/flight_search", isLoggedIn, async (req, res) => {
  const { origin, destination, departure_date, number_of_seats } = req.body;
  if (
    !origin || !destination || !departure_date ||
    !number_of_seats
  ) {
    res.status(404).json({ message: "Please enter all fields" });
  } else {
    const client = await db.connect();
    try {
      const result = await client.query(
        "SELECT f.flight_code, f.departure_time, r.origin, r.destination, a.aircraft_code, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
        [origin, destination, departure_date, number_of_seats],
      );
      if (result.rows.length > 0) {
        const flights = result.rows;
        res.render("flight_page.ejs", {
          flights,
          section: "results",
          messages: req.flash("errors"),
        });
      } else {
        console.error("Error during flight search:", error);
        req.flash("errors", "No flights found");
        res.redirect("/flight_search");
      }
    } catch (error) {
      console.error("Error during booking:", error);
      res.status(500).json({ message: "Internal server error" });
    } finally {
      // Release the client back to the pool
      client.release();
    }
  }
});

router.get("/flight_results", isLoggedIn, (req, res) => {
  // Assuming you have 'flights' data available
  res.render("flight_page.ejs", {
    flights,
    section: "results",
    messages: req.flash("errors"),
  });
});

router.get("/flight_booking", isLoggedIn, (req, res) => {
  res.render("flight_page.ejs", {
    section: "booking",
    messages: req.flash("errors"),
  });
});

router.post("/flight_booking", isLoggedIn, async (req, res) => {
  const { flight_code, type, quantity, discount_code } = req.body;
  if (!flight_code || !type || !quantity || !discount_code) {
    res.status(404).json({ message: "Please enter all fields" });
  } else {
    const client = await db.connect();
    try {
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
        res.redirect("/flight_results");
        return;
      }
      if (type === "Economy" && flight.economy_seat < quantity) {
        req.flash("errors", "Not enough economy seats available!");
        res.redirect("/flight_results");
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
  }
});

module.exports = router;
