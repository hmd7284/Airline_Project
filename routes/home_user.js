const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/home_user", (req, res) => {
  res.render("home_user.ejs");
});

router.get("/user_about", (req, res) => {
  res.render("user_about.ejs");
});

router.get("/user_contacts", (req, res) => {
  res.render("user_contacts.ejs");
});

module.exports = router;
