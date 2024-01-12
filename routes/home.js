const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/", (req, res) => {
  res.redirect("/home");
});

router.get("/about", (req, res) => {
  res.render("about.ejs");
});

router.get("/contacts", (req, res) => {
  res.render("contacts.ejs");
});

router.get("/admin_login", (req, res) => {
  res.render("admin_login.ejs");
});

router.get("/user_login", (req, res) => {
  res.render("user_login.ejs");
});

router.get("/user_signup", (req, res) => {
  res.render("user_signup.ejs");
});

async function fetchAirportsFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT airport_code, address FROM airport",
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
      "SELECT f.flight_code, f.departure_date, f.departure_time, r.origin, r.destination, a.aircraft_code, f.status, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND f.status = 'Success' AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
      [origin, destination, departureDate, numberOfTickets],
    );
    return result.rows;
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
}

router.get("/home", async (req, res) => {
  try {
    const { origin, destination, departureDate, numberOfTickets } = req.query;
    const userInput = req.session.userInput || {};
    const airports = await fetchAirportsFromDatabase();
    if (origin && destination && departureDate && numberOfTickets) {
      if (origin === destination) {
        req.session.userInput = req.query;
        req.flash("error", "Origin and destination cannot be the same!");
        // res.render("user_booking.ejs", {
        //   airports,
        //   transactions,
        //   results: [],
        //   scrollToResults: false,
        //   scrollToSearch: true,
        // });
        res.redirect("/home");
        return;
      }

      const results = await SearchResults(
        origin,
        destination,
        departureDate,
        numberOfTickets,
      );

      res.render("home.ejs", {
        airports,
        userInput,
        results,
        scrollToResults: true,
      });
    }

    res.render("home.ejs", {
      airports,
      userInput,
      results: [],
      scrollToResults: false,
      message: req.flash("error"),
    });
  } catch (error) {
    console.error("Error loading home page:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = router;
