const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");
const bcrypt = require("bcrypt");

router.get("/", (req, res) => {
  res.redirect("/airplane");
});

// router.get("/home", (req, res) => {
//   res.render("home.html");
// });

// router.get("/airport", (req, res) => {
//   res.render("airport.html");
// });

router.get("/airplane", (req, res) => {
  res.render("airplane.ejs");
});

module.exports = router;
