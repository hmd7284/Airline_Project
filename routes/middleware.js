module.exports = {
  isLoggedInAdmin(req, res, next) {
    if (req.session.adminID) {
      next();
    } else res.redirect("/home");
  },
  isLoggedOutAdmin(req, res, next) {
    if (req.session.adminID) {
      res.redirect("/home_admin");
    } else next();
  },
  isLoggedInEmployee(req, res, next) {
    if (req.session.employeeID) {
      next();
    } else res.redirect("/home");
  },
  isLoggedOutEmployee(req, res, next) {
    if (req.session.employeeID) {
      res.redirect("/home_employee");
    } else next();
  },
};
