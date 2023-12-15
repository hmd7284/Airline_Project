const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");
const bcrypt = require("bcrypt");

router.post("/airplane", async (req, res) => {
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
    if (action === "add") {
      const result = await db.query(
        "INSERT INTO aircraft (aircraft_name, capacity, status, mfd_com, mfd_date) VALUES ($1, $2, $3, $4, $5) RETURNING *",
        [aircraftName, capacity, status, mfdCom, mfdDate],
      );

      res.json({
        success: true,
        message: "Aircraft added successfully",
        aircraft: result.rows[0],
      });
    } else if (action === "delete") {
      const result = await db.query(
        "DELETE FROM aircraft WHERE aircraft_code = $1 RETURNING *",
        [aircraftCode],
      );

      if (result.rows.length > 0) {
        res.json({
          success: true,
          message: "Aircraft deleted successfully",
          aircraft: result.rows[0],
        });
      } else {
        res.json({ success: false, message: "Aircraft not found" });
      }
    } else {
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error managing aircraft:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

module.exports = router;
