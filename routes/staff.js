const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function getStaff() {
  const client = await db.connect();
  try {
    const result = await client.query("SELECT * FROM flight_staff");
  }
}
