const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function fetchAircraftFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT * FROM aircraft",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

async function checkFlightsForAircraft(req, aircraftCode, action) {
  const currentTime = new Date();

  // Check for associated flights
  const result = await db.query(
    "SELECT * FROM flight_schedule WHERE aircraft = $1",
    [aircraftCode],
  );

  for (const flight of result.rows) {
    // Check if the flight has already departed and not arrived yet
    const departureTime = new Date(flight.departure_time);
    const arrivalTime = new Date(flight.arrival_time);

    // Check if the flight has departed in the last hour or hasn't arrived yet
    const hasAssociatedFlightsInAir = departureTime <= currentTime &&
      arrivalTime >= currentTime;
    const hasAssociatedFlightsInFuture = departureTime > currentTime;
    if (hasAssociatedFlightsInFuture) {
      if (action === "update") {
        await db.query(
          "DELETE FROM transactions_order WHERE flight_code = ANY( SELECT flight_code FROM flight_schedule WHERE aircraft = $1)",
          [aircraftCode],
        );
      }
    }
    if (hasAssociatedFlightsInAir) {
      const error_message =
        `Aircraft ${aircraftCode} cannot be deactivated. Associated flight is currently in the air.`;
      req.flash(
        "error",
        error_message,
      );
      return true; // Aircraft cannot be deactivated
    }
  }

  return false; // No associated flights that prevent deactivation
}

router.get("/airplane", isLoggedInAdmin, async (req, res) => {
  try {
    const aircrafts = await fetchAircraftFromDatabase();

    const pageSize = 20;
    const pageCount = Math.ceil(aircrafts.length / pageSize);

    const currentPage = parseInt(req.query.page) || 1;

    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const aircraft = aircrafts.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("airplane.ejs", {
      aircraft,
      pageCount,
      currentPage,
      startIdx,
      userInput,
    });
  } catch (error) {
    console.error("Error retrieving aircraft schedule data:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("/airplane", isLoggedInAdmin, async (req, res) => {
  const {
    action,
    aircraftCode1,
    aircraftCode2,
    aircraftName,
    capacity,
    status1,
    status2,
    mfdCom,
    mfdDate,
  } = req.body;
  req.session.userInput = req.body;
  try {
    const existingAircraft1 = await db.query(
      "SELECT * FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode1],
    );
    const existingAircraft2 = await db.query(
      "SELECT * FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode2],
    );
    if (action === "add") {
      if (existingAircraft1.rows.length > 0) {
        const error_message =
          `Aircraft with code ${aircraftCode1} already exists!! Please choose another aircraft`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING aircraft_code",
        [aircraftCode1, aircraftName, capacity, status1, mfdCom, mfdDate],
      );
      if (result.rows.length > 0) {
        success_message = `Aircraft ${aircraftCode1} added successfully`;
        req.flash("success", success_message);
        res.redirect("/airplane");
        return;
      } else {
        const error_message =
          `Aircraft ${aircraftCode1} not added!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
    } else if (action === "update") {
      if (existingAircraft2.rows.length === 0) {
        const error_message =
          `Aircraft with code ${aircraftCode2} not found!! Cannot update status`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      if (status2 === "Active") {
        if (existingAircraft2.rows[0].status === "Active") {
          const error_message =
            `Aircraft with code ${aircraftCode2} is already Active!!`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
        const result = await db.query(
          "UPDATE aircraft SET status = $1 WHERE aircraft_code = $2 RETURNING aircraft_code",
          [status2, aircraftCode2],
        );
        if (result.rows.length > 0) {
          const success_message =
            `Aircraft ${aircraftCode2} status updated successfully`;
          req.flash("success", success_message);
          res.redirect("/airplane");
          return;
        } else {
          const error_message =
            `Aircraft ${aircraftCode2} status is not updated!! Please try again`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
      } else if (status2 === "Inactive") {
        const hasAssociatedFlights = await checkFlightsForAircraft(
          req, aircraftCode2, action
        );
        if (existingAircraft2.rows[0].status === "Inactive") {
          const error_message =
            `Aircraft with code ${aircraftCode2} is already Inactive!!`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
        if (hasAssociatedFlights) {
          res.redirect("/airplane");
          return;
        }
        const result = await db.query(
          "UPDATE aircraft SET status = $1 WHERE aircraft_code = $2 RETURNING aircraft_code", [status2, aircraftCode2],
        );
        if (result.rows.length > 0) {
          const success_message =
            `Aircraft ${aircraftCode2} status updated successfully`;
          req.flash("success", success_message);
          res.redirect("/airplane");
          return; f
        } else {
          const error_message =
            `Aircraft ${aircraftCode2} status not updated!! Please try again`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/airplane");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    req.flash("error", "Error")
    console.error("Error managing aircraft:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = router;
