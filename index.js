const express = require("express");
const session = require("express-session");
const flash = require("connect-flash");
const bodyParser = require("body-parser");
const homeRouter = require("./routes/home");
const homeuserRouter = require("./routes/home_user");
const homeadminRouter = require("./routes/home_admin");
const usersRouter = require("./routes/users");
const adminRouter = require("./routes/admin");
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

app.use(flash());
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
app.use(homeadminRouter);
app.use(adminRouter);
app.use(airplaneRouter);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
