const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/home_user");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/home");
}

// router.get("/user_about", (req, res) => {
//   res.render("user_about.ejs");
// });
//
// router.get("/user_contacts", (req, res) => {
//   res.render("user_contacts.ejs");
// });

async function fetchAirportsFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT airport_code, address FROM airport",
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
      "SELECT f.flight_code, f.departure_date, f.departure_time, r.origin, r.destination, a.aircraft_code, f.status, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND f.status = 'Success' AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
      [origin, destination, departureDate, numberOfTickets],
    );

    return result.rows;
  } catch (error) {
    console.error("Error during flight searching", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
}

router.get("/home_user", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const userInput = req.session.userInput || {};
    res.render("home_user.ejs", {
      airports,
      userInput,
      scrollToResults: false,
      scrollToSearch: true,
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error during home_user", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/home_search", isLoggedIn, async (req, res) => {
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
        res.redirect("/home_search");
        return;
      }

      const results = await SearchResults(
        origin,
        destination,
        departureDate,
        numberOfTickets,
      );

      res.render("home_user.ejs", {
        airports,
        userInput,
        results,
        scrollToResults: true,
        scrollToSearch: false,
        scrollToQueue: false,
      });
    }

    res.render("home_user.ejs", {
      airports,
      userInput,
      results: [],
      scrollToResults: false,
      scrollToSearch: true,
      message: req.flash("error"),
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/user_profile", isLoggedIn, async (req, res) => {
  res.render("user_profile.ejs");
});
module.exports = router;
