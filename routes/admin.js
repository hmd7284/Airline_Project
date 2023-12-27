const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/admin_login", async (req, res) => {
  const { email, password } = req.body;

  try {
    if (!email || !password) {
      return res.status(400).json({ message: "Please enter all fields" });
    }
    const client = await db.connect();
    const results = await client.query(
      "SELECT * FROM account WHERE email = $1 AND type = $2",
      [email, "admin"],
    );

    if (results.rows.length > 0) {
      const admin = results.rows[0];
      if (admin.password === password) {
        req.session.adminID = admin.id;
        res.redirect("/home_admin");
      } else {
        req.flash("error", "Password is not correct");
        res.redirect("/admin_login");
      }
    } else {
      req.flash("error", "Email is not registered");
      res.redirect("/admin_login");
    }
  } catch (error) {
    console.error("Error during admin login:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
});

function isLoggedInAdmin(req, res, next) {
  if (req.session.adminID) {
    next();
  } else res.redirect("/home");
}

function isLoggedOutAdmin(req, res, next) {
  if (req.session.adminID) {
    res.redirect("/home_admin");
  } else next();
}

router.get("/admin_login", isLoggedOutAdmin, (req, res) => {
  res.render("admin_login.ejs", { message: req.flash("error") });
}); //if already logged in, redirect to /adminDashboard

router.get("/admin_logout", isLoggedInAdmin, (req, res) => {
  req.session.destroy();
  res.redirect("/home");
});

router.get("/airplane", isLoggedInAdmin, (req, res) => {
  res.render("airplane.ejs", { message: req.flash("error") });
});

router.post("/airplane", isLoggedInAdmin, async (req, res) => {
  const {
    action,
    aircraftCode,
    aircraftName,
    capacity,
    status,
    mfdCom,
    mfdDate,
  } = req.body;

  try {
    const existingAircraft = await db.query(
      "SELECT * FROM aircraft WHERE aircraft_code = $1",
      [aircraftCode],
    );
    if (action === "add") {
      if (existingAircraft.rows.length > 0) {
        const error_message =
          `Aircraft with code ${aircraftCode} already exists!! Please choose another aircraft`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *",
        [aircraftCode, aircraftName, capacity, status, mfdCom, mfdDate],
      );
      if (result.rows.length > 0) {
        success_message = `Aircraft ${aircraftCode} added successfully`;
        req.flash("success", success_message);
        res.redirect("/airplane");
      } else {
        error_message = `Aircraft ${aircraftCode} not added!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/airplane");
      }
      // res.json({
      //   success: true,
      //   message: "Aircraft added successfully",
      //   aircraft: result.rows[0],
      // });
    } else if (action === "delete") {
      if (existingAircraft.rows.length === 0) {
        const error_message =
          `Aircraft with code ${aircraftCode} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "DELETE FROM aircraft WHERE aircraft_code = $1 RETURNING *",
        [aircraftCode],
      );

      if (result.rows.length > 0) {
        const success_message = `Aircraft ${aircraftCode} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/airplane");
        // res.json({
        //   success: true,
        //   message: "Aircraft deleted successfully",
        //   aircraft: result.rows[0],
        // });
      } else {
        const error_message =
          `Aircraft ${aircraftCode} not deleted!! Please try again`;
        req.flash("error", error_message);
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/airplane");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error managing aircraft:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

router.get("/schedule", isLoggedInAdmin, async (req, res) => {
  try {
    // Fetch flight schedules from the database
    const { rows } = await db.query("SELECT * FROM flight_schedule");

    // Pagination logic
    const pageSize = 20;
    const pageCount = Math.ceil(rows.length / pageSize);
    const currentPage = parseInt(req.query.page) || 1;
    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const flightSchedules = rows.slice(startIdx, endIdx);
    console.log("flightSchedules:", flightSchedules);
    // Render the schedule.ejs template with data
    res.render("schedule.ejs", {
      flightSchedules: flightSchedules,
      pageCount: pageCount,
      currentPage: currentPage,
    });
  } catch (error) {
    console.error("Error retrieving flight schedule data:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("/schedule", isLoggedInAdmin, async (req, res) => {
  const {
    action,
    flight_code,
    departure_date,
    departure_time,
    arrival_date,
    arrival_time,
    aircraft,
    route,
  } = req.body;
  try {
    if (departure_date > arrival_date) {
      req.flash(
        "error",
        "Departure date cannot be after arrival date",
      );
      res.redirect("/schedule");
      return;
    }

    if (departure_date === arrival_date) {
      if (departure_time >= arrival_time) {
        req.flash(
          "error",
          "This flight departs and arrives on the same day, departure time on cannot be after or the same as arrival time",
        );
        res.redirect("/schedule");
        return;
      }
    }
    const existingFlight = await db.query(
      "SELECT * FROM flight_schedule WHERE flight_code = $1",
      [flight_code],
    );
    const availableAircraft = await db.query(
      "SELECT * FROM aircraft WHERE aircraft_code = $1 AND status = $2",
      [aircraft, "Active"],
    );
    if (action === "add") {
      if (
        !flight_code || !departure_date || !departure_time || !arrival_date ||
        !arrival_time || !aircraft || !route
      ) {
        req.flash("error", "Please enter all fields");
        res.redirect("/schedule");
        return;
      }
      if (existingFlight.rows.length > 0) {
        const error_message =
          `Flight with code ${flight_code} already exists!! Please choose another flight`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      } else if (availableAircraft.rows.length === 0) {
        const error_message =
          `Aircraft with code ${aircraft} is not available!! Please choose another aircraft`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      } else {
        const currentDateTime = new Date();
        const departureDateTime = new Date(
          `${departure_date} ${departure_time}`,
        );
        const timeDifference = departureDateTime - currentDateTime;

        if (timeDifference < 24 * 60 * 60 * 1000) { // 24 hours in milliseconds
          req.flash(
            "error",
            "When adding new flights, departure time must be at least 1 day away from the current time",
          );
          res.redirect("/schedule");
          return;
        }

        const result = await db.query(
          "INSERT INTO flight_schedule (flight_code, departure_date, departure_time, arrival_date, arrival_time, aircraft, route) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *",
          [
            flight_code,
            departure_date,
            departure_time,
            arrival_date,
            arrival_time,
            aircraft,
            route,
          ],
        );
        if (result.rows.length > 0) {
          const success_message = `Flight ${flight_code} added successfully`;
          req.flash("success", success_message);
          res.redirect("/schedule");
        } else {
          const error_message =
            `Flight ${flight_code} not added!! Please try again`;
          req.flash("error", error_message);
          res.redirect("/schedule");
        }
      }
    } else if (action === "delete") {
      if (!flight_code) {
        req.flash("error", "Please enter the flight code");
        res.redirect("/schedule");
        return;
      }
      if (existingFlight.rows.length === 0) {
        const error_message =
          `Flight with code ${flight_code} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      const { departure_date, departure_time } = existingFlight.rows[0];
      const departureDateTime = new Date(`${departure_date} ${departure_time}`);
      const currentTime = new Date();

      if (departureDateTime - currentTime < 2 * 60 * 60 * 1000) { // 2 hours in milliseconds
        req.flash(
          "error",
          "Airline can only cancel flight at most 2 hours before departure time",
        );
        res.redirect("/schedule");
        return;
      }

      const result1 = await db.query(
        "DELETE FROM flight_schedule WHERE flight_code = $1 RETURNING *",
        [flight_code],
      );
      const result2 = await db.query(
        "Delete FROM transactions_order WHERE flight_code = $1 RETURNING *",
        [flight_code],
      );
      const id = result2.rows[0].transaction_id;
      const result3 = await db.query(
        "UPDATE transactions SET status = $1 WHERE transaction_id = $2 RETURNING *",
        ["Failed", id],
      );
      if (
        result1.rows.length > 0 && result2.rows.length > 0 &&
        result3.rows.length > 0
      ) {
        const success_message = `Flight ${flight_code} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/schedule");
      } else {
        const error_message =
          `Flight ${flight_code} not deleted!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/schedule");
      }
    } else if (action === "update") {
      if (
        !flight_code || !departure_date || !departure_time || !arrival_date ||
        !arrival_time
      ) {
        // res.status(400).json({
        //   success: false,
        //   message: "Please enter all fields",
        // });
        req.flash("error", "Please enter all fields");
        res.redirect("/schedule");
        return;
      }
      if (existingFlight.rows.length === 0) {
        const error_message =
          `Flight with code ${flight_code} not found!! Cannot update`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      // Extract arrival_date and arrival_time from the existing row
      const { arrival_date, arrival_time } = existingFlight.rows[0];

      // Check if the arrival time is at least 30 minutes away from the current time
      const arrivalDateTime = new Date(`${arrival_date} ${arrival_time}`);
      const currentTime = new Date();

      if (arrivalDateTime - currentTime < 30 * 60 * 1000) { // 30 minutes in milliseconds
        req.flash(
          "error",
          "Arrival time must be at least 30 minutes away from the current time when updating flight schedule",
        );
        res.redirect("/schedule");
        return;
      }
      const result = await db.query(
        "UPDATE flight_schedule SET departure_date = $1, departure_time = $2, arrival_date = $3, arrival_time = $4 WHERE flight_code = $5 RETURNING *",
        [
          departure_date,
          departure_time,
          arrival_date,
          arrival_time,
          flight_code,
        ],
      );
      if (result.rows.length > 0) {
        const success_message =
          `Flight schedule of flight ${flight_code} updated successfully`;
        req.flash("success", success_message);
        res.redirect("/schedule");
      } else {
        const error_message =
          `Flight schedule of ${flight_code} is not updated!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/schedule");
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/schedule");
    }
  } catch (error) {
    console.error("Error managing flight:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});
module.exports = router;
