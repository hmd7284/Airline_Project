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

router.get("/airplane", isLoggedInAdmin, async (req, res) => {
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
        req.flash("error", "Aircraft with the same code already exists");
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *",
        [aircraftCode, aircraftName, capacity, status, mfdCom, mfdDate],
      );
      if (result.rows.length > 0) {
        req.flash("error", "Aircraft added successfully");
        res.redirect("/airplane");
      } else {
        req.flash("error", "Aircraft not added");
        res.redirect("/airplane");
      }
      // res.json({
      //   success: true,
      //   message: "Aircraft added successfully",
      //   aircraft: result.rows[0],
      // });
    } else if (action === "delete") {
      if (existingAircraft.rows.length === 0) {
        req.flash("error", "Aircraft not found!! Cannot delete");
        res.redirect("/airplane");
        return;
      }
      const result = await db.query(
        "DELETE FROM aircraft WHERE aircraft_code = $1 RETURNING *",
        [aircraftCode],
      );

      if (result.rows.length > 0) {
        req.flash("error", "Aircraft deleted successfully");
        res.redirect("/airplane");
        // res.json({
        //   success: true,
        //   message: "Aircraft deleted successfully",
        //   aircraft: result.rows[0],
        // });
      } else {
        req.flash("error", "Aircraft not deleted!! Please try again");
        /* res.json({ success: false, message: "Aircraft not found" }); */
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

module.exports = router;
