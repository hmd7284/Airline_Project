const express = require("express");
const router = express.Router();
const db = require("../database");
const { isLoggedInAdmin } = require("./middleware");

async function fetchDiscountFromDatabase() {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT * FROM discount",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

router.get("/sales", isLoggedInAdmin, async (req, res) => {
  try {
    const discountsdata = await fetchDiscountFromDatabase();

    const pageSize = 20;
    const pageCount = Math.ceil(discountsdata.length / pageSize);

    const currentPage = parseInt(req.query.page) || 1;

    const startIdx = (currentPage - 1) * pageSize;
    const endIdx = startIdx + pageSize;
    const discounts = discountsdata.slice(startIdx, endIdx);
    const userInput = req.session.userInput || {};
    res.render("sales.ejs", {
      discounts,
      pageCount,
      currentPage,
      startIdx,
      userInput,
    });
  } catch (error) {
    console.error("Error retrieving discount data:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post("/sales", isLoggedInAdmin, async (req, res) => {
  const {
    action,
    discountCode,
    title,
    discountAmount,
    description,
  } = req.body;
  req.session.userInput = req.body;
  try {
    const existingDiscount = await db.query(
      "SELECT discount_code FROM discount WHERE discount_code = $1",
      [discountCode],
    );
    if (action === "add") {
      if (existingDiscount.rows.length > 0) {
        const error = `Discount code ${discountCode} already exists`;
        req.flash("error", error);
        res.redirect("/sales");
        return;
      }
      const result = await db.query(
        "INSERT INTO discount (discount_code, title, amount, description) VALUES ($1, $2, $3, $4) RETURNING discount_code",
        [discountCode, title, discountAmount, description],
      );
      if (result.rows.length > 0) {
        const success = `Discount code ${discountCode} has been added`;
        req.flash("success", success);
        res.redirect("/sales");
        return;
      } else {
        const error = `Discount code ${discountCode} could not be added`;
        req.flash("error", error);
        res.redirect("/sales");
        return;
      }
    } else if (action === "delete") {
      if (existingDiscount.rows.length === 0) {
        const error = `Discount code ${discountCode} does not exist`;
        req.flash("error", error);
        res.redirect("/sales");
        return;
      }
      const result = await db.query(
        "DELETE FROM discount WHERE discount_code = $1 RETURNING discount_code",
        [discountCode],
      );
      if (result.rows.length > 0) {
        const success = `Discount code ${discountCode} has been deleted`;
        req.flash("success", success);
        res.redirect("/sales");
        return;
      } else {
        const error = `Discount code ${discountCode} could not be deleted`;
        req.flash("error", error);
        res.redirect("/sales");
        return;
      }
    } else {
      req.flash("error", "Invalid action");
      res.redirect("/sales");
      res.status(400).json({ success: false, message: "Invalid action" });
    }
  } catch (error) {
    console.error("Error saving discount:", error);
    res.status(500).send("Internal Server Error");
  }
});

module.exports = router;
