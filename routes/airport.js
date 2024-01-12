const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function fetchAirportFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT ap.*, c.city_name FROM airport ap JOIN cities c ON ap.city = c.city_code",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/airport", isLoggedInAdmin, async (req, res) => {
  try {
    const airportsdata = await fetchAirportFromDatabase();
    const pageSize = 20;
    const pageCount = Math.ceil(airportsdata.length / pageSize);

    const currentPage = parseInt(req.query.page) || 1;

    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const airports = airportsdata.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("airport.ejs", {
      airports,
      pageCount,
      currentPage,
      startIdx,
      userInput,
    });
  } catch (error) {
    console.error("Error retrieving airport data:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("/airport", isLoggedInAdmin, async (req, res) => {
  const { action, airportCode, airportName, city } = req.body;
  try {
    const existingAirport = await db.query(
      "SELECT airport_code FROM airport WHERE airport_code = $1",
      [airportCode],
    );
    if (action === "add") {
      req.session.userInput = req.body;
      if (existingAirport.rows.length > 0) {
        const error_message =
          `Airport with code ${airportCode} already exists!! Please choose another airport`;
        req.flash("error", error_message);
        res.redirect("/airport");
        return;
      }
      const result = await db.query(
        "INSERT INTO airport (airport_code, airport_name, city) VALUES ($1, $2, $3) RETURNING airport_code",
        [airportCode, airportName, city],
      );
      if (result.rows.length > 0) {
        success_message = `Airport ${airportCode} added successfully`;
        req.flash("success", success_message);
        res.redirect("/airport");
        return;
      } else {
        req.session.userInput = req.body;
        error_message = `Airport ${airportCode} not added!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airport");
        return;
      }
    } else if (action === "delete") {
      if (existingAirport.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Airport with code ${airportCode} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/airport");
        return;
      }
      const result = await db.query(
        "DELETE FROM airport WHERE airport_code = $1 RETURNING airport_code",
        [
          airportCode,
        ],
      );

      if (result.rows.length > 0) {
        const success_message = `Airport ${airportCode} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/airport");
      } else {
        req.session.userInput = req.body;
        const error_message =
          `Airport ${airportCode} not deleted!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airport");
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/airport");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error managing airport:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = router;
