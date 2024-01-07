const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function fetchScheduleFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT fs.*, o.airport_code as origin_code, o.airport_name as origin_name, o.address as origin_address, d.airport_code as destination_code, d.airport_name as destination_name, d.address as destination_address FROM flight_schedule fs JOIN route r ON fs.route = r.route_code JOIN airport o ON r.origin = o.airport_code JOIN airport d ON r.destination = d.airport_code",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

async function fetchRouteFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT r.route_code, o.airport_code AS origin_code, o.airport_name AS origin_name, o.address AS origin_address, d.airport_code AS destination_code, d.airport_name AS destination_name, d.address AS destination_address FROM route r JOIN airport o ON r.origin = o.airport_code JOIN airport d ON r.destination = d.airport_code",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/schedule", isLoggedInAdmin, async (req, res) => {
  try {
    const schedules = await fetchScheduleFromDatabase();
    const flightroutes = await fetchRouteFromDatabase();
    // Pagination logic
    const pageSize = 20;
    const pageCount = Math.ceil(schedules.length / pageSize);
    const currentPage = parseInt(req.query.page) || 1;
    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const flightSchedules = schedules.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("schedule.ejs", {
      flightSchedules,
      flightroutes,
      pageCount,
      currentPage,
      userInput,
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
  req.session.userInput = req.body;
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
      "SELECT (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp, (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp FROM flight_schedule WHERE flight_code = $1",
      [flight_code],
    );
    const aircraftStatusResult = await db.query(
      "SELECT status FROM aircraft WHERE aircraft_code = $1",
      [aircraft],
    );
    const statusResult = await db.query(
      "SELECT status FROM flight_schedule WHERE flight_code = $1",
      [flight_code],
    );

    if (action === "add") {
      origin = req.body.route.slice(0, 3);
      const departureDateTime = new Date(`${departure_date} ${departure_time}`);
      const overlapsFlightSchedule = await db.query(
        "SELECT flight_code FROM flight_schedule WHERE aircraft = $1 AND (CAST($2 || ' ' || $3 AS timestamp), CAST($4 || ' ' || $5 AS timestamp)) OVERLAPS (CAST(departure_date || ' ' || departure_time AS timestamp), CAST(arrival_date || ' ' || arrival_time AS timestamp))",
        [aircraft, departure_date, departure_time, arrival_date, arrival_time],
      );
      // const routeConditionResult = await db.query(
      //   "SELECT fs.flight_code FROM flight_schedule fs JOIN route r ON fs.route = r.route_code WHERE fs.aircraft = $1 AND r.destination = $2 AND (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) < CAST($3 || ' ' || $4 AS timestamp)) ORDER BY fs.departure_date DESC LIMIT 1",
      //   [aircraft, origin, departure_date, departure_time],
      // );
      if (existingFlight.rows.length > 0) {
        const error_message =
          `Flight with code ${flight_code} already exists!! Please choose another flight`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      } else if (aircraftStatusResult.rows[0].status === "Inactive") {
        const error_message =
          `Aircraft with code ${aircraft} is not available!! Please choose another aircraft`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      } else if (overlapsFlightSchedule.rows.length > 0) {
        const overlappingFlightCodes = overlapsFlightSchedule.rows.map((
          flight,
        ) => flight.flight_code);

        const error_message =
          `Aircraft ${aircraft} has schedule conflicts with the following flights: ${
            overlappingFlightCodes.join(", ")
          }`;

        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      } /* else if (routeConditionResult.rows.length === 0) { */
      //   const error_message =
      //     `Aircraft ${aircraft} is not currently at ${origin} airport!! Please choose another aircraft`;
      //   req.flash("error", error_message);
      //   res.redirect("/schedule");
      //   return;
      else {
        const currentDateTime = new Date();
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
          "INSERT INTO flight_schedule (flight_code, departure_date, departure_time, arrival_date, arrival_time, aircraft, route) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING flight_code",
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
      if (existingFlight.rows.length === 0) {
        const error_message =
          `Flight with code ${flight_code} not found!! Cannot cancel`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      if (statusResult.rows[0].status === "Canceled") {
        const error_message =
          `Flight ${flight_code} has already been canceled!!`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      /* const { departure_date, departure_time } = existingFlight.rows[0]; */
      const departureTimeStamp = existingFlight.rows[0].departure_timestamp;
      /* const departureDateTime = new Date(`${departure_date} ${departure_time}`); */
      const departureDateTime = new Date(`${departureTimeStamp}`);
      const currentDateTime = new Date();
      const timeDifference = departureDateTime - currentDateTime;
      console.log(timeDifference);
      if (timeDifference < 0) {
        const error_message =
          `Flight ${flight_code} has already departed!! It cannot be cancelled`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      if (timeDifference < 30 * 60 * 1000) { // 20 minutes in milliseconds
        req.flash(
          "error",
          "Airline can only cancel flight at most 30 minutes before departure time",
        );
        res.redirect("/schedule");
        return;
      }

      const result1 = await db.query(
        "UPDATE flight_schedule SET status = 'Canceled' WHERE flight_code = $1 RETURNING flight_code",
        [
          flight_code,
        ],
      );
      const result2 = await db.query(
        "Delete FROM transactions_order WHERE flight_code = $1 RETURNING order_id",
        [flight_code],
      );
      if (result1.rows.length > 0) {
        if (result2.rows.length > 0) {
          const success_message =
            `Flight ${flight_code} and associated orders canceled successfully`;
          req.flash("success", success_message);
          res.redirect("/schedule");
          return;
        }
        const success_message = `Flight ${flight_code} canceled successfully`;
        req.flash("success", success_message);
        res.redirect("/schedule");
        return;
      } else {
        const error_message =
          `Failed to cancel flight ${flight_code} !! Please try again`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
    } else if (action === "del") {
      if (existingFlight.rows.length === 0) {
        const error_message =
          `Flight with code ${flight_code} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      const result = await db.query(
        "DELETE FROM flight_schedule WHERE flight_code = $1 RETURNING flight_code",
        [flight_code],
      );
      if (result.rows.length > 0) {
        const success_message = `Flight ${flight_code} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/schedule");
      } else {
        const error_message =
          `Flight ${flight_code} not deleted!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
    } else if (action === "update") {
      if (existingFlight.rows.length === 0) {
        const error_message =
          `Flight with code ${flight_code} not found!! Cannot update`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      if (statusResult.rows[0].status === "Canceled") {
        const error_message =
          `Flight ${flight_code} has been canceled!! You can't update its flight time`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      // Extract arrival_date and arrival_time from the existing row
      /* const { arrival_date, arrival_time } = existingFlight.rows[0]; */
      const departureTimeStamp = existingFlight.rows[0].departure_timestamp;
      const arrivalTimeStamp = existingFlight.rows[0].arrival_timestamp;
      const arrivalDateTime = new Date(`${arrival_date} ${arrival_time}`);
      const departureDateTime = new Date(`${departure_date} ${departure_time}`);
      const dpDateTime = new Date(`${departureTimeStamp}`);
      const aDateTime = new Date(`${arrivalTimeStamp}`);
      const currentTime = new Date();
      const departureTimeDifference = departureDateTime - currentTime;
      const arrivalTimeDifference = arrivalDateTime - currentTime;
      const departureTimeDifference2 = currentTime - dpDateTime;
      const arrivalTimeDifference2 = aDateTime - currentTime;
      // Check if the arrival time is at least 30 minutes away from the current time
      if (
        (departure_date || departure_time || arrival_date || arrival_time) &&
        (arrivalTimeDifference2 < 0)
      ) {
        req.flash(
          "error",
          "The flight has already arrived!! Its schedule cannot be updated",
        );
        res.redirect("/schedule");
        return;
      }

      if ((departure_date && departure_time) && departureTimeDifference2 > 0) {
        const error_message =
          `Flight ${flight_code} has departed!! Its departure date and time cannot be updated`;
        req.flash("error", error_message);
        res.redirect("/schedule");
        return;
      }
      if (
        departure_date && departure_time &&
        departureTimeDifference < 30 * 60 * 1000
      ) { // 30 minutes in milliseconds
        req.flash(
          "error",
          "Departure time must be at least 30 minutes away from the current time when updating flight schedule",
        );
        res.redirect("/schedule");
        return;
      }
      if (
        arrival_date && arrival_time && arrivalTimeDifference < 30 * 60 * 1000
      ) { // 30 minutes in milliseconds
        req.flash(
          "error",
          "Arrival time must be at least 30 minutes away from the current time when updating flight schedule",
        );
        res.redirect("/schedule");
        return;
      }
      const result = await db.query(
        "UPDATE flight_schedule SET departure_date = $1, departure_time = $2, arrival_date = $3, arrival_time = $4 WHERE flight_code = $5 RETURNING flight_code",
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
