const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");

router.get("/home_admin", (req, res) => {
  res.render("home_admin.ejs");
});

module.exports = router;
