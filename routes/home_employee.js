const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedInEmployee(req, res, next) {
  if (req.session.employeeID) {
    next();
  } else res.redirect("/home");
}

function isLoggedOutEmployee(req, res, next) {
  if (req.session.employeeID) {
    res.redirect("/home_employee");
  } else next();
}

async function fetchWorkingSchedule(employeeId) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT fs.*, o.airport_code as origin_code, o.airport_name as origin_name, o.address as origin_address, d.airport_code as destination_code, d.airport_name as destination_name, d.address as destination_address FROM flight_staff fst JOIN flight_schedule fs ON fs.flight_code = fst.flight_code JOIN route r ON fs.route = r.route_code JOIN airport o ON r.origin = o.airport_code JOIN airport d ON r.destination = d.airport_code WHERE fst.employee_id = $1 ORDER BY fs.departure_date ASC, fs.departure_time ASC",
      [employeeId],
    );
    console.log(result.rows);
    return result.rows;
  } finally {
    client.release();
  }
}

async function fetchWorkingScheduleInDateRange(employeeId, startDate, endDate) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT fs.*, o.airport_code as origin_code, o.airport_name as origin_name, o.address as origin_address, d.airport_code as destination_code, d.airport_name as destination_name, d.address as destination_address FROM flight_staff fst JOIN flight_schedule fs ON fs.flight_code = fst.flight_code JOIN route r ON fs.route = r.route_code JOIN airport o ON r.origin = o.airport_code JOIN airport d ON r.destination = d.airport_code WHERE fst.employee_id = $1 AND fs.departure_date BETWEEN $2 AND $3 ORDER BY fs.departure_date ASC, fs.departure_time ASC",
      [employeeId, startDate, endDate],
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/home_employee", isLoggedInEmployee, async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    const userInput = req.session.userInput || {};
    let workingSchedule;
    if (start_date && end_date) {
      if (start_date && end_date && new Date(end_date) < new Date(start_date)) {
        req.session.userInput = req.query;
        const error_message =
          "End Date must be greater than or equal to Start Date.";
        req.flash("error", error_message);
        res.redirect("/home_employee");
        return;
      }
      workingSchedule = await fetchWorkingScheduleInDateRange(
        req.session.employeeID,
        start_date,
        end_date,
      );
      if (workingSchedule.length === 0) {
        req.session.userInput = req.query;
        const error_message = "No working schedule found.";
        req.flash("error", error_message);
      }
    } else {
      workingSchedule = await fetchWorkingSchedule(
        req.session.employeeID,
      );
    }
    console.log(workingSchedule);
    res.render("home_employee.ejs", {
      workingSchedule,
      userInput,
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error retrieving data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = router;
