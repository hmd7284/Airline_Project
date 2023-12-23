const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/booking");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/home_user");
}
// router.get("/booking", isLoggedIn, (req, res) => {
//   res.render("booking.ejs", { messages: req.flash("errors") });
// }); //must log in to see

async function fetchAirportsFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT * FROM airport",
    );
    return result.rows;
  } finally {
    // Release the client back to the pool
    client.release();
  }
}

router.get("/booking", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    res.render("booking_form.ejs", { airports });
  } catch (error) {
    console.error("Error fetching airport data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_result", isLoggedIn, (req, res) => {
  res.render("flight_result.ejs");
});

router.get("/make_booking", isLoggedIn, (req, res) => {
  res.render("flight_result.ejs");
});

router.post("/booking", isLoggedIn, async (req, res) => {
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
        res.render("flight_result.ejs", { flights });
      } else {
        req.flash("errors", "No flights found");
        res.redirect("/booking");
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

// router.post("/make_booking", isLoggedIn, async (req, res) => {
//   const { flight_code, num_economy_tickets, num_business_tickets, discount_code } = req.body;
//   if (!flight_code || !num_economy_tickets || !num_business_tickets) {
//     res.status(404).json({ message: "Please enter all fields" });
//   }
//   else {
//     const client = await db.connect();
//     try {
//       const transactionResult = await client.query(
//       "INSERT INTO transactions (booking_date, customer_id, discount, total_amount) VALUES (current_date, $1, $2, $3) RETURNING transaction_id",
//       [req.session.userId, discount_code, 0],
//       );
//       const transactionId = transactionResult.rows[0].transaction_id;
//     }
//   }
// });
module.exports = router;
