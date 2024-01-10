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

async function fetchAirportsFromDatabase() {
  const client = await db.connect();

  try {
    const result = await client.query(
      "SELECT airport_code, address FROM airport",
    );
    return result.rows;
  } finally {
    client.release();
  }
}

async function SearchResults(
  origin,
  destination,
  departureDate,
  numberOfTickets,
) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT f.flight_code, f.departure_date, f.departure_time, r.origin, r.destination, a.aircraft_code, f.status, a.aircraft_name, af1.price as economy_price, af2.price as business_price FROM aircraft a JOIN flight_schedule f ON a.aircraft_code = f.aircraft JOIN route r ON f.route = r.route_code JOIN airfare af1 ON af1.route = r.route_code AND af1.TYPE = 'Economy' JOIN airfare af2 ON af2.route = r.route_code AND af2.TYPE = 'Business' WHERE r.origin = $1 AND r.destination = $2 AND f.departure_date = $3 AND f.status = 'Success' AND ((CAST(f.departure_date || ' ' || f.departure_time AS timestamp))::timestamptz >= current_timestamp + INTERVAL '4 hours') AND (f.business_seat + f.economy_seat >= $4) ORDER BY f.departure_time ASC",
      [origin, destination, departureDate, numberOfTickets],
    );
    console.log(result.rows);
    return result.rows;
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
}

async function fetchBookingHistory(userId, transactionId) {
  const client = await db.connect();
  try {
    const result = await client.query(
      "SELECT t.transaction_id, t.booking_date, t.status, t.discount, t.total_amount, o.order_id, o.flight_code, r.origin, r.destination, o.type, o.price, o.quantity, o.total FROM transactions t LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id JOIN flight_schedule fs ON o.flight_code = fs.flight_code JOIN route r ON fs.route = r.route_code WHERE t.customer_id = $1 and t.transaction_id = $2",
      [userId, transactionId],
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
        origin: row.origin,
        destination: row.destination,
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

router.get("/flight_search", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const userInput = req.session.userInput || {};
    const transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
      userInput,
      scrollToResults: false,
      scrollToSearch: true,
      scrollToQueue: false,
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_search_results", isLoggedIn, async (req, res) => {
  try {
    const { origin, destination, departureDate, numberOfTickets } = req.query;
    const userInput = req.session.userInput || {};
    const airports = await fetchAirportsFromDatabase();
    const transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    if (origin && destination && departureDate && numberOfTickets) {
      if (origin === destination) {
        req.session.userInput = req.query;
        req.flash("error", "Origin and destination cannot be the same!");
        // res.render("user_booking.ejs", {
        //   airports,
        //   transactions,
        //   results: [],
        //   scrollToResults: false,
        //   scrollToSearch: true,
        // });
        res.redirect("/flight_search_results");
        return;
      }

      const results = await SearchResults(
        origin,
        destination,
        departureDate,
        numberOfTickets,
      );

      res.render("user_booking.ejs", {
        airports,
        transactions,
        userInput,
        results,
        scrollToResults: true,
        scrollToSearch: false,
        scrollToQueue: false,
      });
    }

    res.render("user_booking.ejs", {
      airports,
      transactions,
      userInput,
      results: [],
      scrollToResults: false,
      scrollToSearch: true,
      scrollToQueue: false,
      message: req.flash("error"),
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_booking", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const userInput = req.session.userInput || {};
    const transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
      scrollToQueue: false,
      userInput,
      scrollToResults: false,
      scrollToSearch: false,
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post("/flight_booking", isLoggedIn, async (req, res) => {
  const { fcode, type, amount, discount } = req.body;
  const discountValue = discount !== "" ? discount : null;
  console.log(discountValue);
  try {
    const flight_query = await db.query(
      "SELECT business_seat, economy_seat FROM flight_schedule WHERE flight_code = $1",
      [fcode],
    );
    if (flight_query.rows.length === 0) {
      req.session.userInput = req.body;
      console.log("Flight not found");
      const error_message = `Flight ${fcode} not found`;
      req.flash(
        "error",
        error_message,
      );
      res.redirect("/flight_booking");
      return;
    }
    const flight = flight_query.rows[0];
    if (type === "Business" && flight.business_seat < amount) {
      req.session.userInput = req.body;
      console.log("Not enough business seats available");
      req.flash("error", "Not enough business seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (type === "Economy" && flight.economy_seat < amount) {
      req.session.userInput = req.body;
      console.log("Not enough economy seats available");
      req.flash("error", "Not enough economy seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (discountValue !== null) {
      const discount_query = await db.query(
        "SELECT title FROM discount WHERE discount_code = $1",
        [discountValue],
      );
      if (discount_query.rows.length === 0) {
        req.session.userInput = req.body;
        console.log("Discount code not found");
        const error_message = `Discount code ${discountValue} not found`;
        req.flash("error", error_message);
        res.redirect("/flight_booking");
        return;
      }
    }
    if (!req.session.transactionId) {
      let transactionResult;
      if (discountValue !== null) {
        transactionResult = await db.query(
          "INSERT INTO transactions (booking_date, customer_id, discount) VALUES (current_date, $1, $2) RETURNING transaction_id",
          [req.session.userId, discountValue],
        );
      } else {
        transactionResult = await db.query(
          "INSERT INTO transactions (booking_date, customer_id) VALUES (current_date, $1) RETURNING transaction_id",
          [req.session.userId],
        );
      }
      if (transactionResult.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error creating transaction");
        res.redirect("/flight_booking");
        return;
      }
      const transactionId = transactionResult.rows[0].transaction_id;
      req.session.transactionId = transactionId;
      console.log(req.body);
      const orderResult = await db.query(
        "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4) RETURNING order_id",
        [transactionId, fcode, type, amount],
      );
      console.log(orderResult.rows);
      if (orderResult.rows.length > 0) {
        req.flash("success", "Successfully added order!");
        res.redirect("/booking_queue");
      } else {
        req.session.userInput = req.body;
        req.flash("error", "Error Creating Order");
        res.redirect("/flight_booking");
        return;
      }
    } else {
      const orderResult = await db.query(
        "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4) RETURNING order_id",
        [req.session.transactionId, fcode, type, amount],
      );
      if (orderResult.rows.length > 0) {
        req.flash("success", "Successfully added order!");
        res.redirect("/booking_queue");
      } else {
        req.session.userInput = req.body;
        req.flash("error", "Error creating order");
        res.redirect("/flight_booking");
        return;
      }
    }
  } catch (error) {
    // console.error("Error during booking:", error);
    // res.status(500).send("Internal Server Error");
    console.error("Error during booking:", error);
    req.flash("error", "Internal server error");
    res.redirect("/flight_booking");
  }
});

router.get("/booking_queue", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const userInput = req.session.userInput || {};
    const transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
      userInput,
      scrollToQueue: true,
      scrollToResults: false,
      scrollToSearch: false,
    });
  } catch (error) {
    console.error("Error retrieving booking history:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.get("/booking_queue/confirmation", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    const userInput = req.session.userInput || {};
    const transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );
    res.render("user_booking.ejs", {
      airports,
      transactions,
      userInput,
      scrollToQueue: false,
      scrollToResults: false,
      scrollToSearch: false,
    });
  } catch (error) {
    req.flash("error", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

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
router.post(
  "/booking_queue/cancel/:transactionId",
  isLoggedIn,
  async (req, res) => {
    if (!req.session.transactionId) {
      req.flash("error", "No transaction found");
      res.redirect("/booking_queue");
      return;
    }
    const client = await db.connect();
    const transactionId = req.params.transactionId;
    try {
      // const uncancellableOrders = await checkUncancellableOrders(transactionId);

      // if (uncancellableOrders.length > 0) {
      //   const errorMessage = `Order ${uncancellableOrders.join(", ")
      //     } of the transaction (${transactionId}) cannot be cancelled !! Therefore, the transaction can't be cancelled!!`;
      //   req.flash("error", errorMessage);
      //   res.redirect("/booking_queue");
      //   return;
      // }
      const result = await client.query(
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
    } catch (error) {
      console.error("Error cancelling transaction:", error);
      res.status(500).send("Internal Server Error");
    } finally {
      req.session.scrollToTransaction = req.session.transactionId;
      req.session.transactionId = null;
      client.release();
      res.redirect(
        `/booking_history?transactionId=${req.session.scrollToTransaction}`,
      );
    }
  },
);

router.post(
  "/booking_queue/cancel/order/:transactionId/:orderId",
  isLoggedIn,
  async (req, res) => {
    if (!req.session.transactionId) {
      req.flash("error", "No transaction found");
      res.redirect("/booking_queue");
      return;
    }
    const { transactionId, orderId } = req.params;
    try {
      const result = await db.query(
        "DELETE FROM transactions_order WHERE transaction_id = $1 AND order_id = $2 RETURNING order_id",
        [transactionId, orderId],
      );
      if (result.rows.length === 0) {
        // No rows were deleted, so the order was not found
        const error_message =
          `Order ${orderId} of transaction ${transactionId} not found`;
        req.flash("error", error_message);
        res.redirect("/booking_queue");
        return;
      }
      // } else {
      //   const success_message =
      //     `Your order ${orderId} of transaction ${transactionId} has been cancelled successfully`;
      //   req.flash("success", success_message);
      //   res.redirect("/booking_queue");
      // }
    } catch (error) {
      console.error("Error cancelling order:", error);
      res.status(500).send("Internal Server Error");
    }
  },
);

router.post("/booking_queue/confirmation", isLoggedIn, async (req, res) => {
  if (!req.session.transactionId) {
    req.flash("error", "No transaction found");
    res.redirect("/booking_queue");
    return;
  }
  const client = await db.connect();
  try {
    const statusResult = await client.query(
      "SELECT status FROM transactions WHERE transaction_id = $1",
      [req.session.transactionId],
    );
    if (statusResult.rows.length === 0) {
      req.flash("error", "No transaction found");
      res.redirect("/booking_queue");
      return;
    }
    const status = statusResult.rows[0].status;
    if (status === "Failed") {
      req.flash("error", "Transaction failed");
    } else {
      req.flash("success", "Transaction successful");
    }
  } catch (error) {
    console.error("Error confirming transaction:", error);
    res.status(500).send("Internal Server Error");
  } finally {
    req.session.scrollToTransaction = req.session.transactionId;
    req.session.transactionId = null;
    client.release();
    res.redirect(
      `/booking_history?transactionId=${req.session.scrollToTransaction}`,
    );
  }
});
module.exports = router;
