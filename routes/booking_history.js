const express = require("express");
const router = express.Router();
const db = require("../database");
const path = require("path");

router.get("/booking_history", (req, res) => {
  res.render("booking_history.ejs");
});

// Set up a route to handle requests for My Booking data with optional filtering
router.post("/booking_history", async (req, res) => {
  const client = await db.connect();
  try {
    const page = req.query.page || 1;
    const perPage = 6;
    const offset = (page - 1) * perPage;

    // Get start and end dates from query parameters
    const startDate = req.query.start_date;
    const endDate = req.query.end_date;

    // Construct the base SQL query
    let queryText = "SELECT * FROM my_booking";

    // Add WHERE clause for date filtering if start and end dates are provided
    const queryValues = [];
    if (startDate && endDate) {
      queryText += "WHERE start_date >= $1 AND end_date <= $2";
      queryValues.push(startDate, endDate);
    }

    queryText += " LIMIT $3 OFFSET $4";

    const result = await client.query({
      text: queryText,
      values: [...queryValues, perPage, offset],
    });

    const bookings = result.rows;

    // Fetch total records count for pagination
    let totalQueryText = "SELECT COUNT(*) FROM my_booking";
    if (startDate && endDate) {
      totalQueryText += " WHERE start_date >= $1 AND end_date <= $2";
    }

    const totalResult = await client.query(totalQueryText, queryValues);
    const totalRecords = totalResult.rows[0].count;
    const totalPages = Math.ceil(totalRecords / perPage);

    res.json({
      bookings,
      totalPages,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message || "Internal Server Error" });
  }
});

module.exports = router;
