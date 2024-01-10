const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/", (req, res) => {
  res.redirect("/home");
});

router.get("/home", (req, res) => {
  res.render("home.ejs");
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

router.get("/home", async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    res.render("home.ejs", { airports });
  } catch (error) {
    console.error("Error loading home page:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = router;
