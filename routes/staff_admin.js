const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin, isLoggedOutAdmin } = require("./middleware");

async function fetchStaff(flight_code) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT e.name, s.*, fs.departure_date, fs.departure_time, fs.status FROM employee e JOIN flight_staff s ON e.employee_id = s.employee_id JOIN flight_schedule fs ON s.flight_code = fs.flight_code WHERE s.flight_code = $1",
      [flight_code],
    );
    if (result.rows.length === 0) {
      return [];
    }
    const staffs = [];
    let currentStaff = null;
    for (const row of result.rows) {
      if (
        !currentStaff ||
        currentStaff.flight_code !== row.flight_code
      ) {
        // New transaction
        currentStaff = {
          flight_code: row.flight_code,
          departure_date: row.departure_date,
          status: row.status,
          staffsinfo: [],
        };
        staffs.push(currentStaff);
      }

      // Add order information to the current transaction
      currentStaff.staffsinfo.push({
        employee_id: row.employee_id,
        name: row.name,
      });
    }

    return staffs;
  } finally {
    client.release();
  }
}

router.get("/staff", isLoggedInAdmin, async (req, res) => {
  try {
    const fcode = req.query.fcode;
    const userInput = req.session.userInput || {};
    req.session.userInput = req.query;
    let staffs = [];
    if (fcode) {
      staffs = await fetchStaff(fcode);
    }
    // if (staffs.length === 0) {
    //   req.flash("error", `No schedule found for flight with code ${fcode}`);
    //   /* res.redirect("/staff"); */
    //   return;
    // }
    res.render("staff_admin.ejs", {
      staffs: staffs || [],
      userInput,
    });
  } catch (error) {
    console.error("Error loading staff data", error);
    res.status(500).send("Error loading staff data");
  }
});

router.post("/staff", isLoggedInAdmin, async (req, res) => {
  const {
    action,
    employee_id1,
    employee_id2,
    flight_code1,
    flight_code2,
  } = req.body;
  try {
    if (action === "add") {
      const existFlight1 = await db.query(
        "SELECT status from flight_schedule WHERE flight_code = $1",
        [flight_code1],
      );
      if (existFlight1.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message = `Flight ${flight_code1} does not exist`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      if (existFlight1.rows[0].status === "Canceled") {
        req.session.userInput = req.body;
        const error_message = `Flight ${flight_code1} is canceled`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }

      const existStaff1 = await db.query(
        "SELECT name from employee WHERE employee_id = $1",
        [employee_id1],
      );
      if (existStaff1.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Employee does not exist");
        res.redirect("/staff");
        return;
      }

      const existingSchedule1 = await db.query(
        "SELECT flight_code from flight_staff WHERE employee_id = $1 and flight_code = $2",
        [employee_id1, flight_code1],
      );
      if (existingSchedule1.rows.length > 0) {
        req.session.userInput = req.body;
        const error_message =
          `Employee ${employee_id1} is already assigned to flight ${flight_code1}`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      // const overlapsSchedule1 = await db.query(
      //   "SELECT fst2.flight_code from flight_staff fst1 JOIN flight_staff fst2 ON fst1.employee_id = fst2.employee_id JOIN flight_schedule fs1 ON fst1.flight_code = fs1.flight_code JOIN flight_schedule fs2 ON fst2.flight_code = fs2.flight_code WHERE fs1.flight_code = $1 AND fst1.employee_id = $2 AND fst1.flight_code != fst2.flight_code AND (CAST(fs1.departure_date || ' ' || fs1.departure_time AS timestamp), CAST(fs1.arrival_date || ' ' || fs1.arrival_time AS timestamp)) OVERLAPS (CAST(fs2.departure_date || ' ' || fs2.departure_time AS timestamp), CAST(fs2.arrival_date || ' ' || fs2.arrival_time AS timestamp))",
      //   [flight_code1, employee_id1],
      // );
      const departedFlight = await db.query(
        "SELECT (CAST(departure_date || ' ' | departure_time AS timestamp)) as departure_timestamp FROM flight_schedule WHERE flight_code = $1",
        [flight_code1],
      );
      const departureTimeStamp = departedFlight.rows[0].departure_timestamp;
      const departedDateTime = new Date(`${departureTimeStamp}`);
      const currentDateTime = new Date();
      const timeDifferece = departedDateTime - currentDateTime;
      if (timeDifferece < 0) {
        req.session.userInput = req.body;
        const error_message =
          `Flight ${flight_code1} has already departed!! You can't add staff to this flight`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      if (timeDifferece < 30 * 60 * 1000) {
        req.session.userInput = req.body;
        const error_message =
          `Flight ${flight_code1} is departing in less than 30 minutes!! You can't add staff to this flight`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      const overlapsSchedule1 = await db.query(
        "SELECT fst2.flight_code FROM flight_staff fst1 JOIN flight_staff fst2 ON fst1.employee_id = fst2.employee_id JOIN flight_schedule fs1 ON fst1.flight_code = fs1.flight_code JOIN flight_schedule fs2 ON fst2.flight_code = fs2.flight_code WHERE fs1.flight_code = $1 AND fst1.employee_id = $2 AND fst1.flight_code != fst2.flight_code AND tsrange(fs1.departure_date + fs1.departure_time, fs1.arrival_date + fs1.arrival_time, '[]') && tsrange(fs2.departure_date + fs2.departure_time, fs2.arrival_date + fs2.arrival_time, '[]')",
        [flight_code1, employee_id1],
      );
      if (overlapsSchedule1.rows.length > 0) {
        req.session.userInput = req.body;
        const error_message =
          `Employee ${employee_id1} is already assigned to another flight that has schedule conflict with this flight ${flight_code1}`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      const result = await db.query(
        "INSERT INTO flight_staff (flight_code, employee_id) VALUES ($1, $2)",
        [flight_code1, employee_id1],
      );
      if (result.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error inserting staff data");
        res.redirect("/staff");
        return;
      } else {
        req.flash("success", "Successfully added staff");
        res.redirect("/staff");
        return;
      }
    } else if (action === "delete") {
      const existFlight2 = await db.query(
        "SELECT status from flight_schedule WHERE flight_code = $1",
        [flight_code2],
      );
      if (existFlight2.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message = `Flight ${flight_code2} does not exist`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      const existStaff2 = await db.query(
        "SELECT name from employee WHERE employee_id = $1",
        [employee_id2],
      );
      if (existStaff2.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Employee does not exist");
        res.redirect("/staff");
        return;
      }
      const existingSchedule2 = await db.query(
        "SELECT flight_code from flight_staff WHERE employee_id = $1 and flight_code = $2",
        [employee_id2, flight_code2],
      );
      if (existingSchedule2.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Employee ${employee_id2} is not assigned to flight ${flight_code2}`;
        req.flash("error", error_message);
        res.redirect("/staff");
        return;
      }
      const result = await db.query(
        "DELETE FROM flight_staff WHERE employee_id = $1 and flight_code = $2 RETURNING employee_id",
        [employee_id2, flight_code2],
      );
      if (result.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error deleting staff data");
        // res.redirect("/staff");
        // return;
      } else {
        req.flash("success", "Successfully deleted staff");
        // res.redirect("/staff");
        // return;
      }
      res.redirect("/staff");
      return;
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/staff");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error inserting staff data", error);
    res.status(500).send("Error inserting staff data");
  }
});

module.exports = router;
