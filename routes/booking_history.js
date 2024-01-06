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

async function fetchBookingHistoryWithDateRange(
  userId,
  startDate,
  endDate,
) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT t.transaction_id, t.booking_date, t.status, t.discount, t.total_amount, o.order_id, o.flight_code, o.type, o.price, o.quantity, o.total FROM transactions t LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id WHERE t.customer_id = $1 AND t.booking_date BETWEEN $2 AND $3",
      [userId, startDate, endDate],
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

async function checkUncancellableOrders(transactionId) {
  const result = await db.query(
    "SELECT o.order_id, (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) as time_difference FROM flight_schedule fs JOIN transactions_order o ON fs.flight_code = o.flight_code WHERE o.transaction_id = $1",
    [transactionId],
  );
  const uncancellableOrders = [];

  for (const order of result.rows) {
    const timeDifferenceInHours = result.rows[0].time_difference.hours;

    if (timeDifferenceInHours === undefined) {
      uncancellableOrders.push(order.order_id);
    } else if (timeDifferenceInHours !== undefined) {
      if (Math.abs(timeDifferenceInHours) < 3) {
        uncancellableOrders.push(order.order_id);
      }
    }
  }
  return uncancellableOrders;
}
router.get("/booking_history", isLoggedIn, async (req, res) => {
  try {
    const { startDate, endDate } = req.query;
    const userInput = req.session.userInput || {};
    req.session.userInput = req.query;
    let transactions;

    if (startDate && endDate) {
      if (startDate && endDate && new Date(endDate) < new Date(startDate)) {
        const error_message =
          "End Date must be greater than or equal to Start Date.";
        req.flash("error", error_message);
        res.redirect("/booking_history");
        return;
      }
      transactions = await fetchBookingHistoryWithDateRange(
        req.session.userId,
        startDate,
        endDate,
      );
      if (transactions.length === 0) {
        const error_message =
          "You made no transaction in the specified date range.";
        req.flash("error", error_message);
      }
    } else {
      transactions = await fetchBookingHistory(req.session.userId);
    }
    res.render("user_history.ejs", { transactions, userInput });
  } catch (error) {
    console.error("Error retrieving booking history:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post(
  "/booking_history/cancel/:transactionId",
  isLoggedIn,
  async (req, res) => {
    const transactionId = req.params.transactionId;
    try {
      const uncancellableOrders = await checkUncancellableOrders(transactionId);

      if (uncancellableOrders.length > 0) {
        const errorMessage = `Ordera ${
          uncancellableOrders.join(", ")
        } of the transaction (${transactionId}) cannot be cancelled !! Therefore, the transaction can't be cancelled!!`;
        req.flash("error", errorMessage);
        res.redirect("/booking_history");
        return;
      }
      const result = await db.query(
        "UPDATE transactions SET status = 'Failed' WHERE transaction_id = $1 RETURNING transaction_id",
        [transactionId],
      );
      if (result.rows.length === 0) {
        // No rows were deleted, so the transaction was not found
        const error_message = `Transaction ${transactionId} not found`;
        req.flash("error", error_message);
        res.redirect("/booking_history");
        return;
      }
      const success_message =
        `Transaction ${transactionId} and associated orders cancelled successfully`;
      req.flash("success", success_message);
      res.redirect("/booking_history");
    } catch (error) {
      console.error("Error cancelling transaction:", error);
      res.status(500).send("Internal Server Error");
    }
  },
);
router.post(
  "/booking_history/cancel/order/:transactionId/:orderId",
  isLoggedIn,
  async (req, res) => {
    const { transactionId, orderId } = req.params;
    try {
      const timeDifferenceResult = await db.query(
        "SELECT (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) as time_difference FROM flight_schedule fs JOIN transactions_order o ON fs.flight_code = o.flight_code WHERE o.transaction_id = $1 AND o.order_id = $2",
        [transactionId, orderId],
      );
      console.log(timeDifferenceResult.rows[0].time_difference);
      if (
        !timeDifferenceResult.rows[0] ||
        timeDifferenceResult.rows[0].time_difference === null
      ) {
        const error_message =
          `Unable to determine time difference for order ${orderId} of transaction ${transactionId}`;
        req.flash("error", error_message);
        res.redirect("/booking_history");
        return;
      }
      const timeDifferenceInHours =
        timeDifferenceResult.rows[0].time_difference.hours;
      const timeDifferenceInMinutes =
        timeDifferenceResult.rows[0].time_difference.minutes;
      const timeDifferenceInSeconds =
        timeDifferenceResult.rows[0].time_difference.seconds;
      console.log(timeDifferenceInHours);
      if (timeDifferenceInHours === undefined) {
        if (timeDifferenceInMinutes === undefined) {
          if (
            timeDifferenceInSeconds !== undefined && timeDifferenceInSeconds < 0
          ) {
            // Departure time has passed
            const error_message =
              `Cancellation of orders is not allowed after departure time`;
            req.flash("error", error_message);
            return res.redirect("/booking_history");
          } else if (
            timeDifferenceInSeconds !== undefined &&
            timeDifferenceInSeconds < 60 && timeDifferenceInSeconds > 0
          ) {
            const error_message =
              `Cancellation of orders can only be done at most 3 hours before departure time. You can't cancel this order.`;
            req.flash("error", error_message);
            res.redirect("/booking_history");
            return;
          }
        } else if (timeDifferenceInMinutes < 0) {
          // Departure time has passed
          const error_message =
            `Cancellation of orders is not allowed after departure time`;
          req.flash("error", error_message);
          return res.redirect("/booking_history");
        } else if (
          timeDifferenceInMinutes < 60 && timeDifferenceInMinutes > 0
        ) {
          const error_message =
            `Cancellation of orders can only be done at most 3 hours before departure time. You can't cancel this order.`;
          req.flash("error", error_message);
          res.redirect("/booking_history");
          return;
        }
      }
      if (timeDifferenceInHours !== undefined && timeDifferenceInHours < 0) {
        // Departure time has passed
        const error_message =
          `Cancellation of orders is not allowed after departure time`;
        req.flash("error", error_message);
        return res.redirect("/booking_history");
      }

      if (
        timeDifferenceInHours !== undefined &&
        Math.abs(timeDifferenceInHours) < 3
      ) {
        const error_message =
          `Cancellation of orders can only be done at most 3 hours before departure time. You can't cancel this order.`;
        req.flash("error", error_message);
        res.redirect("/booking_history");
        return;
      }
      const result = await db.query(
        "DELETE FROM transactions_order WHERE transaction_id = $1 AND order_id = $2 RETURNING order_id",
        [transactionId, orderId],
      );
      if (result.rows.length === 0) {
        // No rows were deleted, so the order was not found
        const error_message =
          `Order ${orderId} of transaction ${transactionId} not found`;
        req.flash("error", error_message);
        res.redirect("/booking_history");
        return;
      } else {
        const success_message =
          `Your order ${orderId} of transaction ${transactionId} has been cancelled successfully`;
        req.flash("success", success_message);
        res.redirect("/booking_history");
      }
    } catch (error) {
      console.error("Error cancelling order:", error);
      res.status(500).send("Internal Server Error");
    }
  },
);
module.exports = router;
