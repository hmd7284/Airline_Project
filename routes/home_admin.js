const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/home_admin", (req, res) => {
  res.render("home_admin.ejs");
});

router.get("/staff", (req, res) => {
  res.render("staff.ejs");
});

module.exports = router;
