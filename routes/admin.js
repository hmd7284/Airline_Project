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
router.use("/", loginlogoutRouter);
router.use("/", airplaneRouter);
router.use("/", scheduleRouter);

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

// router.get("/route", isLoggedInAdmin, async (req, res) => {
//   try {
//     const routesdata = await fetchRouteFromDatabase();
//     const airports = await fetchAirportFromDatabase();
//     const pageSize = 20;
//     const pageCount = Math.ceil(routesdata.length / pageSize);

//     const currentPage = parseInt(req.query.page) || 1;

//     const startIdx = (currentPage - 1) * pageSize;
//     const endIdx = startIdx + pageSize;
//     const routes = routesdata.slice(startIdx, endIdx);

//     res.render("route.ejs", {
//       routes,
//       airports,
//       pageCount,
//       currentPage,
//       startIdx,
//     });
//   } catch (error) {
//     console.error("Error retrieving data:", error);
//     res.status(500).send("Internal Server Error");
//   }
// });

// router.post("/route", isLoggedInAdmin, async (req, res) => {
//   const { action, routeCode, origin, destination } = req.body;
//   try {
//     const existingRoute = await db.query(
//       "SELECT * FROM route WHERE route_code = $1",
//       [routeCode],
//     );
//     if (routeCode.length !== 6) {
//       req.flash("error", "Route code must have 6 characters.");
//       res.redirect("/route");
//       return;
//     }
//     if (action === "add") {
//       if (origin === destination) {
//         req.flash(
//           "error",
//           "Origin and destination cannot be the same",
//         );
//         res.redirect("/route");
//         return;
//       }
//       if (routeCode.substring(0, 3) !== origin) {
//         req.flash(
//           "error",
//           "First 3 characters of route code must be the same as the origin",
//         );
//         res.redirect("/route");
//         return;
//       }
//       if (routeCode.substring(3, 6) !== destination) {
//         req.flash(
//           "error",
//           "Last 3 characters of route code must be the same as the destination",
//         );
//         res.redirect("/route");
//         return;
//       }
//       if (existingRoute.rows.length > 0) {
//         const error_message =
//           `Route with code ${routeCode} already exists!! Please choose another route`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//         return;
//       }
//       const availableOrigin = await db.query(
//         "SELECT * FROM airport WHERE airport_code = $1",
//         [origin],
//       );
//       const availableDestination = await db.query(
//         "SELECT * FROM airport WHERE airport_code = $1",
//         [destination],
//       );
//       if (availableOrigin.rows.length === 0) {
//         const error_message =
//           `Origin airport with code ${origin} does not exist!! Please choose another airport`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//         return;
//       }
//       if (availableDestination.rows.length === 0) {
//         const error_message =
//           `Destination airport with code ${destination} does not exist!! Please choose another airport`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//         return;
//       }
//       const result = await db.query(
//         "INSERT INTO route (route_code, origin, destination) VALUES ($1, $2, $3) RETURNING *",
//         [routeCode, origin, destination],
//       );
//       if (result.rows.length > 0) {
//         success_message = `Route ${routeCode} added successfully`;
//         req.flash("success", success_message);
//         res.redirect("/route");
//       } else {
//         error_message = `Route ${routeCode} not added!! Please try again`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//       }
//     } else if (action === "delete") {
//       if (existingRoute.rows.length === 0) {
//         const error_message =
//           `Route with code ${routeCode} not found!! Cannot delete`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//         return;
//       }
//       const result = await db.query(
//         "DELETE FROM route WHERE route_code = $1 RETURNING *",
//         [routeCode],
//       );

//       if (result.rows.length > 0) {
//         const success_message = `Route ${routeCode} deleted successfully`;
//         req.flash("success", success_message);
//         res.redirect("/route");
//       } else {
//         const error_message =
//           `Route ${routeCode} not deleted!! Please try again`;
//         req.flash("error", error_message);
//         res.redirect("/route");
//       }
//     } else {
//       req.flash("error", "Invalid action");
//       res.redirect("/route");
//       res.status(400).json({ success: false, message: "Invalid action" });
//     }
//   } catch (error) {
//     console.error("Error managing route:", error);
//     res.status(500).json({ success: false, message: "Internal server error" });
//   }
// });

module.exports = router;
