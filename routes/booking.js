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
router.get("/booking", isLoggedIn, (req, res) => {
  res.render("booking.ejs", { messages: req.flash("errors") });
}); //must log in to see

router.post("/booking", isLoggedIn, async (req, res) => {
  const { origin, destination, departure_date, number_of_seats } = req.body;
  if (!origin || !destination || !departure_date || !number_of_seats) {
    res.status(404).json({ message: "Please enter all fields" });
  } else {
    const client = await db.connect();
    try {
      const result = await client.query(
        "SELECT f.flight_code, f.departure_time, r.origin, r.destination, a.aircraft_code, a.aircraft_name, af.price FROM flight f JOIN aircraft a ON f.aircraft = a.aircraft_code JOIN route r ON f.route = r.route_code JOIN air_fare af ON af.route = r.route_code WHERE r.origin = $1 AND r.destination = $2 AND f.departure_time::date = $3 AND f.remaining_seat >= $4 ORDER BY f.departure_time ASC",
        [origin, destination, departure_date, number_of_seats],
      );
      if (result.rows.length > 0) {
        const flights = result.rows;
        res.render("booking.ejs", { flights });
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

module.exports = router;
