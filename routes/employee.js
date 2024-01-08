const express = require("express");
const router = express.Router();
const db = require("../database");

const loginoutRouter = require("./employee_login_logout");
router.use("/", loginoutRouter);

module.exports = router;
