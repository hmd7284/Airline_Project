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
const airportRouter = require("./airport");
const airplaneRouter = require("./airplane");
const scheduleRouter = require("./schedule");
const flightRouteRouter = require("./flight_route");
const discountRouter = require("./sales");
router.use("/", loginlogoutRouter);
router.use("/", airportRouter);
router.use("/", airplaneRouter);
router.use("/", scheduleRouter);
router.use("/", flightRouteRouter);
router.use("/", discountRouter);
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

module.exports = router;
