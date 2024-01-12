const express = require("express");
const router = express.Router();
const db = require("../database");

const { isLoggedInAdmin, isLoggedOutAdmin } = require("./middleware");
async function fetchEmployeeFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT * FROM employee ORDER BY employee_id ASC",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/employee_list", isLoggedInAdmin, async (req, res) => {
  try {
    const employees = await fetchEmployeeFromDatabase();

    const pageSize = 20;
    const pageCount = Math.ceil(employees.length / pageSize);

    const currentPage = parseInt(req.query.page) || 1;

    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const employee = employees.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("employee_list.ejs", {
      employee,
      pageCount,
      currentPage,
      startIdx,
      userInput,
    });
  } catch (error) {
    console.error("Error retrieving employee schedule data:", error);
    res.status(500).send("Internal Server Error");
  }
});

module.exports = router;
