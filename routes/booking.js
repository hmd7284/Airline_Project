const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/flight_booking");
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
    console.log(result.rows);
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
    transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
      scrollToResults: false,
      scrollToSearch: true,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_search_results", isLoggedIn, async (req, res) => {
  try {
    const { origin, destination, departureDate, numberOfTickets } = req.query;
    const airports = await fetchAirportsFromDatabase();
    transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    if (origin && destination && departureDate && numberOfTickets) {
      if (origin === destination) {
        req.flash("errors", "Origin and destination cannot be the same!");
        res.render("user_booking.ejs", {
          airports,
          transactions,
          results: [],
          scrollToResults: false,
          scrollToSearch: true,
        });
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
        results,
        scrollToResults: true,
        scrollToSearch: false,
      });
      return;
    }

    // Render the search form when parameters are missing
    res.render("user_booking.ejs", {
      airports,
      transactions,
      results: [],
      scrollToResults: false,
      scrollToSearch: true,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/flight_booking", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
      scrollToResults: false,
      scrollToSearch: false,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post("/flight_booking", isLoggedIn, async (req, res) => {
  const { fcode, type, amount, discount } = req.body;
  const client = await db.connect();
  try {
    const flight_query = await client.query(
      "SELECT business_seat, economy_seat FROM flight_schedule WHERE flight_code = $1",
      [fcode],
    );
    if (flight_query.rows.length === 0) {
      req.flash(
        "errors",
        "Flight not found! Make sure you enter the correct flight code.",
      );
      res.redirect("/flight_search_results");
      return;
    }
    const flight = flight_query.rows[0];
    if (type === "Business" && flight.business_seat < amount) {
      req.flash("errors", "Not enough business seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (type === "Economy" && flight.economy_seat < amount) {
      req.flash("errors", "Not enough economy seats available!");
      res.redirect("/flight_booking");
      return;
    }
    if (!req.session.transactionId) {
      const transactionResult = await client.query(
        "INSERT INTO transactions (booking_date, customer_id, discount, total_amount) VALUES (current_date, $1, $2, $3) RETURNING transaction_id",
        [req.session.userId, discount, 0],
      );
      const transactionId = transactionResult.rows[0].transaction_id;
      req.session.transactionId = transactionId;
      const orderResult = await client.query(
        "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4)",
        [transactionId, fcode, type, amount],
      );
      if (orderResult.rows.length > 0) {
        req.flash("sucess", "Successfully booked ticket!");
        res.redirect("/flight_booking");
        return;
      } else {
        req.flash("errors", "Error during booking");
        res.redirect("/flight_booking");
        return;
      }
    } else {
      const orderResult = await client.query(
        "INSERT INTO transactions_order (transaction_id, flight_code, type, quantity) VALUES ($1, $2, $3, $4)",
        [req.session.transactionId, fcode, type, amount],
      );
      if (orderResult.rows.length > 0) {
        req.flash("sucess", "Successfully booked ticket!");
        res.redirect("/booking_queue");
        return;
      } else {
        req.flash("errors", "Error during booking");
        res.redirect("/flight_booking");
        return;
      }
    }
  } catch (error) {
    console.error("Error during booking:", error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
});

router.get("/booking_queue", isLoggedIn, async (req, res) => {
  try {
    const airports = await fetchAirportsFromDatabase();
    transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );

    res.render("user_booking.ejs", {
      airports,
      transactions,
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
    transactions = await fetchBookingHistory(
      req.session.userId,
      req.session.transactionId,
    );
    res.render("user_booking.ejs", {
      airports,
      transactions,
      scrollToResults: false,
      scrollToSearch: false,
    });
  } catch (error) {
    req.flash("errors", "Error fetching data");
    console.error("Error fetching data:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post(
  "/booking_queue/cancel/order/:transactionId/:orderId",
  isLoggedIn,
  async (req, res) => {
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
      } else {
        const success_message =
          `Your order ${orderId} of transaction ${transactionId} has been cancelled successfully`;
        req.flash("success", success_message);
        res.redirect("/booking_queue");
      }
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
    res.redirect("/booking_history/:transactionId");
  }
});
module.exports = router;
