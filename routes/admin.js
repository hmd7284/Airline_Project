const express = require("express");
const router = express.Router();
const db = require("../database");

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

const loginlogoutRouter = require("./admin_login_logout");
const airplaneRouter = require("./airplane");
const scheduleRouter = require("./schedule");
const flightRouteRouter = require("./flight_route");
router.use("/", loginlogoutRouter);
router.use("/", airplaneRouter);
router.use("/", scheduleRouter);
router.use("/", flightRouteRouter);
// async function fetchAirportFromDatabase() {
//   const client = await db.connect();
//   try {
//     const result = await client.query(
//       "SELECT * FROM airport",
//     );
//     return result.rows;
//   } finally {
//     client.release();
//   }
// }

// async function fetchRouteFromDatabase() {
//   const client = await db.connect();
//   try {
//     const result = await client.query(
//       "SELECT r.route_code, o.airport_code AS origin_code, o.airport_name AS origin_name, o.address AS origin_address, d.airport_code AS destination_code, d.airport_name AS destination_name, d.address AS destination_address FROM route r JOIN airport o ON r.origin = o.airport_code JOIN airport d ON r.destination = d.airport_code",
//     );
//     return result.rows;
//   } finally {
//     client.release();
//   }
// }

// router.get("/airport", isLoggedInAdmin, async (req, res) => {
//   try {
//     const airports = await fetchAirportFromDatabase();
//     const pageSize = 20;
//     const pageCount = Math.ceil(airports.length / pageSize);

//     const currentPage = parseInt(req.query.page) || 1;

//     const startIdx = (currentPage - 1) * pageSize;
//     const endIdx = startIdx + pageSize;
//     const airport = airports.slice(startIdx, endIdx);

//     res.render("airport.ejs", {
//       airport,
//       pageCount,
//       currentPage,
//       startIdx,
//     });
//   } catch (error) {
//     console.error("Error retrieving airport data:", error);
//     res.status(500).send("Internal Server Error");
//   }
// });

// router.post("/airport", isLoggedInAdmin, async (req, res) => {
//   const { action, airportCode, airportName, address, city } = req.body;
//   try {
//     const existingAirport = await db.query(
//       "SELECT * FROM airport WHERE airport_code = $1",
//       [airportCode],
//     );
//     if (action === "add") {
//       if (existingAirport.rows.length > 0) {
//         const error_message =
//           `Airport with code ${airportCode} already exists!! Please choose another airport`;
//         req.flash("error", error_message);
//         res.redirect("/airport");
//         return;
//       }
//       const result = await db.query(
//         "INSERT INTO airport (airport_code, airport_name, address, city) VALUES ($1, $2, $3, $4) RETURNING *",
//         [airportCode, airportName, address, city],
//       );
//       if (result.rows.length > 0) {
//         success_message = `Airport ${airportCode} added successfully`;
//         req.flash("success", success_message);
//         res.redirect("/airport");
//         return;
//       } else {
//         error_message = `Airport ${airportCode} not added!! Please try again`;
//         req.flash("error", error_message);
//         res.redirect("/airport");
//         return;
//       }
//     } else if (action === "delete") {
//       if (existingAirport.rows.length === 0) {
//         const error_message =
//           `Airport with code ${airportCode} not found!! Cannot delete`;
//         req.flash("error", error_message);
//         res.redirect("/airport");
//         return;
//       }
//       const result = await db.query(
//         "DELETE FROM airport WHERE airport_code = $1 RETURNING *",
//         [
//           airportCode,
//         ],
//       );

//       if (result.rows.length > 0) {
//         const success_message = `Airport ${airportCode} deleted successfully`;
//         req.flash("success", success_message);
//         res.redirect("/airport");
//       } else {
//         const error_message =
//           `Airport ${airportCode} not deleted!! Please try again`;
//         req.flash("error", error_message);
//         res.redirect("/airport");
//       }
//     } else {
//       req.flash("error", "Invalid action");
//       res.redirect("/airport");
//       res.status(400).json({ success: false, message: "Invalid action" });
//     }
//   } catch (error) {
//     console.error("Error managing airport:", error);
//     res.status(500).json({ success: false, message: "Internal server error" });
//   }
// });

module.exports = router;