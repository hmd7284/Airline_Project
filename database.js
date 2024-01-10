const { Pool } = require("pg");
const db = new Pool({
  user: "postgres",
  database: "airline",
  password: "2685",
  port: "5432",
  host: "localhost",
});

const connectDB = async () => {
  try {
    await db.connect();
    console.log("Connected to the database");
  } catch (err) {
    console.error("Error connecting to the database:", err);
  }
};

connectDB();

module.exports = db;
