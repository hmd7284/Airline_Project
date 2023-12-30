const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/flight_search");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/home");
}

async function fetchBookingHistory(userId) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT t.transaction_id, t.booking_date, t.status, t.discount, t.total_amount, o.order_id, o.flight_code, o.type, o.price, o.quantity, o.total FROM transactions t LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id WHERE customer_id = $1",
      [userId],
    );
    const transactions = [];
    let currentTransaction = null;
    for (const row of result.rows) {
      if (
        !currentTransaction ||
        currentTransaction.transaction_id !== row.transaction_id
      ) {
        // New transaction
        currentTransaction = {
          transaction_id: row.transaction_id,
          booking_date: row.booking_date,
          status: row.status,
          discount: row.discount,
          total_amount: row.total_amount,
          orders: [],
        };
        transactions.push(currentTransaction);
      }

      // Add order information to the current transaction
      currentTransaction.orders.push({
        order_id: row.order_id,
        flight_code: row.flight_code,
        type: row.type,
        price: row.price,
        quantity: row.quantity,
        total: row.total,
      });
    }
    return transactions;
  } finally {
    client.release();
  }
}

router.get("/booking_history", isLoggedIn, async (req, res) => {
  try {
    // Fetch booking history data from the database
    const transactions = await fetchBookingHistory(req.session.userId);

    // Render the booking history page with the fetched data
    res.render("booking_history.ejs", { transactions });
  } catch (error) {
    console.error("Error retrieving booking history:", error);
    res.status(500).send("Internal Server Error");
  }
});

module.exports = router;
