const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/flight_booking");
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
    console.log(result.rows);
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
      "SELECT f.flight_code, f.departure_date, f.departure_time, r.origin, r.destination, a.aircraft_code, f.status, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND f.status = 'Success' AND ((CAST(f.departure_date || ' ' || f.departure_time AS timestamp))::timestamptz >= current_timestamp + INTERVAL '4 hours') AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
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

// router.get("/flight_search", isLoggedOut, (req, res) => {
//   try {
//     const airports = fetchAirportsFromDatabase();
//     res.render("user_booking.ejs", {
//       airports,
//       scrollToResults: false,
//       scrollToSearch: true,
//       results: [], // or any other default value
//     });
//   } catch (error) {
//     console.error("Error fetching data:", error);
//     res.status(500).json({ message: "Internal server error" });
// }
router.get("/flight_search", isLoggedIn, async (req, res) => {
  try {
    const { origin, destination, departureDate, numberOfTickets } = req.query;
    console.log(req.query);
    const airports = await fetchAirportsFromDatabase();
    if (origin && destination && departureDate && numberOfTickets) {
      if (origin === destination) {
        req.flash("errors", "Origin and destination cannot be the same!");
        res.render("user_booking.ejs", {
          airports,
          results: [], // or any other default value
          scrollToResults: false,
          scrollToSearch: true,
        });
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
        scrollToResults: true,
        scrollToSearch: false,
      });
    }
    res.render("user_booking.ejs", {
      airports,
      scrollToResults: false,
      scrollToSearch: true,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_booking", isLoggedIn, (req, res) => {
  res.render("user_booking.ejs", {
    messages: req.flash("errors"),
  });
});

router.post("/flight_booking", isLoggedIn, async (req, res) => {
  const { fcode, type, amount, discount } = req.body;
  const client = await db.connect();
  try {
    const flight_query = await client.query(
      "SELECT business_seat, economy_seat FROM flight_schedule WHERE flight_code = $1",
      [fcode],
    );
    if (flight_query.rows.length === 0) {
      req.flash(
        "errors",
        "Flight not found! Make sure you enter the correct flight code.",
      );
      res.redirect("/flight_booking");
      return;
    }
    const flight = flight_query.rows[0];
    if (type === "Business" && flight.business_seat < amount) {
      req.flash("errors", "Not enough business seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (type === "Economy" && flight.economy_seat < amount) {
      req.flash("errors", "Not enough economy seats available!");
      res.redirect("/flight_booking");
      return;
    }
    const transactionResult = await client.query(
      "INSERT INTO transactions (booking_date, customer_id, discount, total_amount) VALUES (current_date, $1, $2, $3) RETURNING transaction_id",
      [req.session.userId, discount, 0],
    );
    const transactionId = transactionResult.rows[0].transaction_id;
    const orderResult = await client.query(
      "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4)",
      [transactionId, fcode, type, amount],
    );
    if (orderResult.rows.length > 0) {
      req.flash("sucess", "Successfully booked ticket!");
      res.redirect("/flight_booking");
      return;
    } else {
      req.flash("errors", "Error during booking");
      res.redirect("/flight_booking");
      return;
    }
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
});

async function getFlightInfo(flightCode, ticketType) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT fs.flight_code, fs.departure_date, fs.departure_time, fs.arrival_date, fs.arrival_time, fs.aircraft, fs.route, fs.business_seat, fs.economy_seat, r.origin, r.destination, af.price, af.type " +
        "FROM flight_schedule fs " +
        "INNER JOIN route r ON fs.route = r.route_code " +
        "INNER JOIN airfare af ON fs.route = af.route AND af.type = $1 " +
        "WHERE fs.flight_code = $2 AND af.type = $3",
      [ticketType, flightCode, ticketType],
    );
    return result.rows[0];
  } catch (error) {
    console.error("Error executing SQL query:", error);
    throw error;
  }
}

router.get("/getFlightInfo", isLoggedIn, async (req, res) => {
  const { flight_code, type } = req.query;

  try {
    const flightInfo = await getFlightInfo(flight_code, type);
    res.json(flightInfo);
  } catch (error) {
    console.error("Error getting flight info:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
