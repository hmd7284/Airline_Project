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
};
