const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

router.get("/revenue", isLoggedInAdmin, async (req, res) => {
  const client = await db.connect();
  try {
    const insightsresult = await client.query("SELECT * FROM airline_insights");

    res.render("revenue.ejs", { insights: insightsresult.rows }); // Pass all rows
  } catch (err) {
    console.error(err);
    res.send("Error " + err);
  } finally {
    client.release();
  }
});
module.exports = router;
