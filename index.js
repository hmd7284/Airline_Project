const express = require("express");
require("dotenv").config();
const session = require("express-session");
const bodyParser = require("body-parser");
const homeRouter = require("./routes/home");
const airplaneRouter = require("./routes/airplane");
const app = express();
const port = 5000;
const oneDay = 1000 * 60 * 60 * 24;
app.use(session({
  secret: "thisismysecretkey",
  saveUninitialized: true,
  cookie: { maxAge: oneDay },
  resave: false,
}));

app.use(express.static("public"));
app.set("view engine", "ejs");
app.set("views", "pages");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());

app.use((req, res, next) => {
  res.locals.session = req.session;
  next();
});

app.use(homeRouter);
app.use(airplaneRouter);
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
