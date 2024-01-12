const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin, isLoggedOutAdmin } = require("./middleware");

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
    aircraftCode3,
    aircraftName,
    capacity,
    status1,
    status2,
    mfdCom,
    mfdDate,
  } = req.body;
  try {
    const existingAircraft1 = await db.query(
      "SELECT aircraft_name FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode1],
    );
    const existingAircraft2 = await db.query(
      "SELECT aircraft_name,status FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode2],
    );
    const existingAircraft3 = await db.query(
      "SELECT aircraft_name,status FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode3],
    );

    if (action === "add") {
      if (existingAircraft1.rows.length > 0) {
        req.session.userInput = req.body;
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
        req.session.userInput = req.body;
        const error_message =
          `Aircraft ${aircraftCode1} not added!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
    } else if (action === "delete") {
      if (existingAircraft3.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Aircraft with code ${aircraftCode3} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "DELETE FROM aircraft WHERE aircraft_code = $1 RETURNING aircraft_code",
        [aircraftCode3],
      );
      if (result.rows.length > 0) {
        const success_message =
          `Aircraft ${aircraftCode3} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/airplane");
        return;
      } else {
        req.session.userInput = req.body;
        const error_message =
          `Aircraft ${aircraftCode3} not deleted!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
    } else if (action === "update") {
      if (existingAircraft2.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Aircraft with code ${aircraftCode2} not found!! Cannot update status`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      if (status2 === "Active") {
        req.session.userInput = req.body;
        if (existingAircraft2.rows[0].status === "Active") {
          const error_message =
            `Aircraft with code ${aircraftCode2} is already Active!!`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
        const result = await db.query(
          "UPDATE aircraft SET status = 'Active' WHERE aircraft_code = $1 RETURNING aircraft_code",
          [aircraftCode2],
        );
        if (result.rows.length > 0) {
          const success_message =
            `Aircraft ${aircraftCode2} status updated successfully`;
          req.flash("success", success_message);
          res.redirect("/airplane");
          return;
        } else {
          req.session.userInput = req.body;
          const error_message =
            `Aircraft ${aircraftCode2} status is not updated!! Please try again`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
      } else if (status2 === "Inactive") {
        if (existingAircraft2.rows[0].status === "Inactive") {
          req.session.userInput = req.body;
          const error_message =
            `Aircraft with code ${aircraftCode2} is already Inactive!!`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }
        const flightInAir = await db.query(
          "SELECT flight_code FROM flight_schedule WHERE aircraft = $1 AND (current_timestamp(0) BETWEEN CAST(departure_date || ' ' || departure_time AS timestamp) AND CAST(arrival_date || ' ' || arrival_time AS timestamp))",
          [aircraftCode2],
        );
        if (flightInAir.rows.length > 0) {
          req.session.userInput = req.body;
          const error_message =
            `Aircraft ${aircraftCode2} cannot be deactivated. Associated flight is currently in the air.`;
          req.flash("error", error_message);
          res.redirect("/airplane");
          return;
        }

        const result = await db.query(
          "UPDATE aircraft SET status = 'Inactive' WHERE aircraft_code = $1 RETURNING aircraft_code",
          [aircraftCode2],
        );
        if (result.rows.length > 0) {
          const success_message =
            `Aircraft ${aircraftCode2} status updated successfully`;
          req.flash("success", success_message);
          res.redirect("/airplane");
          return;
        } else {
          req.session.userInput = req.body;
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
    req.flash("error", "Error");
    console.error("Error managing aircraft:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = router;
