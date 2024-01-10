const express = require("express");
const session = require("express-session");
const flash = require("connect-flash");
const bodyParser = require("body-parser");
const homeRouter = require("./routes/home");
const homeuserRouter = require("./routes/home_user");
const usersRouter = require("./routes/users");
const adminRouter = require("./routes/admin");
const bookingRouter = require("./routes/booking");
const bookinghistoryRouter = require("./routes/booking_history");
const employeeRouter = require("./routes/employee");
const app = express();
const port = 5000;

const oneDay = 1000 * 60 * 60 * 24;
app.use(session({
  secret: "thisismysecretkey",
  saveUninitialized: true,
  cookie: { maxAge: oneDay },
  resave: false,
}));

app.use(flash());
app.use(function (req, res, next) {
  res.locals.message = req.flash();
  next();
});
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
app.use(homeuserRouter);
app.use(usersRouter);
app.use(bookinghistoryRouter);
app.use(adminRouter);
app.use(bookingRouter);
app.use(employeeRouter);
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
