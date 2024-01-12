const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function fetchAirportFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT * FROM airport",
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

router.get("/route", isLoggedInAdmin, async (req, res) => {
  try {
    const routesdata = await fetchRouteFromDatabase();
    const airports = await fetchAirportFromDatabase();
    const pageSize = 20;
    const pageCount = Math.ceil(routesdata.length / pageSize);

    const currentPage = parseInt(req.query.page) || 1;

    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const routes = routesdata.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("route.ejs", {
      routes,
      userInput,
      airports,
      pageCount,
      currentPage,
      startIdx,
    });
  } catch (error) {
    console.error("Error retrieving data:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("/route", isLoggedInAdmin, async (req, res) => {
  const { action, routeCode, origin, destination } = req.body;
  try {
    const existingRoute = await db.query(
      "SELECT route_code FROM route WHERE route_code = $1",
      [routeCode],
    );
    if (routeCode.length !== 6) {
      req.session.userInput = req.body;
      req.flash("error", "Route code must have 6 characters.");
      res.redirect("/route");
      return;
    }
    if (action === "add") {
      if (origin === destination) {
        req.session.userInput = req.body;
        req.flash(
          "error",
          "Origin and destination cannot be the same",
        );
        res.redirect("/route");
        return;
      }
      if (routeCode.substring(0, 3) !== origin) {
        req.session.userInput = req.body;
        req.flash(
          "error",
          "First 3 characters of route code must be the same as the origin",
        );
        res.redirect("/route");
        return;
      }
      if (routeCode.substring(3, 6) !== destination) {
        req.session.userInput = req.body;
        req.flash(
          "error",
          "Last 3 characters of route code must be the same as the destination",
        );
        res.redirect("/route");
        return;
      }
      if (existingRoute.rows.length > 0) {
        req.session.userInput = req.body;
        const error_message =
          `Route with code ${routeCode} already exists!! Please choose another route`;
        req.flash("error", error_message);
        res.redirect("/route");
        return;
      }
      const availableOrigin = await db.query(
        "SELECT airport_name FROM airport WHERE airport_code = $1",
        [origin],
      );
      const availableDestination = await db.query(
        "SELECT airport_name FROM airport WHERE airport_code = $1",
        [destination],
      );
      if (availableOrigin.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Origin airport with code ${origin} does not exist!! Please choose another airport`;
        req.flash("error", error_message);
        res.redirect("/route");
        return;
      }
      if (availableDestination.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Destination airport with code ${destination} does not exist!! Please choose another airport`;
        req.flash("error", error_message);
        res.redirect("/route");
        return;
      }
      const result = await db.query(
        "INSERT INTO route (route_code, origin, destination) VALUES ($1, $2, $3) RETURNING route_code",
        [routeCode, origin, destination],
      );
      if (result.rows.length > 0) {
        success_message = `Route ${routeCode} added successfully`;
        req.flash("success", success_message);
        res.redirect("/route");
      } else {
        req.session.userInput = req.body;
        error_message = `Route ${routeCode} not added!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/route");
      }
    } else if (action === "delete") {
      if (existingRoute.rows.length === 0) {
        req.session.userInput = req.body;
        const error_message =
          `Route with code ${routeCode} not found!! Cannot delete`;
        req.flash("error", error_message);
        res.redirect("/route");
        return;
      }
      const result = await db.query(
        "DELETE FROM route WHERE route_code = $1 RETURNING route_code",
        [routeCode],
      );

      if (result.rows.length > 0) {
        const success_message = `Route ${routeCode} deleted successfully`;
        req.flash("success", success_message);
        res.redirect("/route");
      } else {
        req.session.userInput = req.body;
        const error_message =
          `Route ${routeCode} not deleted!! Please try again`;
        req.flash("error", error_message);
        res.redirect("/route");
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/route");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error managing route:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = router;
