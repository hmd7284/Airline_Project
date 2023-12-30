const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/", (req, res) => {
  res.redirect("/home");
});

router.get("/home", (req, res) => {
  res.render("new_home.ejs");
});

router.get("/home_user", (req, res) => {
  res.render("home_user.ejs");
});

router.get("/about", (req, res) => {
  res.render("about.ejs");
});

router.get("/contacts", (req, res) => {
  res.render("contacts.ejs");
});

router.get("/admin_login", (req, res) => {
  res.render("admin_login.ejs");
});

router.get("/user_login", (req, res) => {
  res.render("user_login.ejs");
});

router.get("/user_signup", (req, res) => {
  res.render("user_signup.ejs");
});

module.exports = router;
