const express = require("express");
const router = express.Router();
const db = require("../database");

// router.post("/admin_login", (req, res) => {
//   const { email, password } = req.body;
//   if (!email | !password) {
//     res.status(404).json({ message: "Please enter all fields" });
//   } else {
//     db.query(
//       `select * from account where email='admin@gmail.com' and type = 'admin'`,
//       (err, results) => {
//         if (err) throw err;
//         if (results.length > 0) {
//           const admin = results[0];
//           if (admin.password === password) {
//             session = req.session;
//             session.adminID = admin.id;
//             res.redirect("/home_admin");
//             console.log("Login successfully");
//           } else {
//             req.flash("error", "Password is not correct");
//             console.log("Password is not correct");
//             res.redirect("/admin_login");
//           }
//         } else {
//           console.log("Email is not registered");
//           req.flash("error", "Email is not registered");
//           res.redirect("/admin_login");
//         }
//       },
//     );
//   }
// });

router.post("/admin_login", async (req, res) => {
  const { email, password } = req.body;

  try {
    if (!email || !password) {
      return res.status(400).json({ message: "Please enter all fields" });
    }
    const client = await db.connect();
    const results = await client.query(
      "SELECT * FROM account WHERE email = $1 AND type = $2",
      [email, "admin"],
    );

    if (results.rows.length > 0) {
      const admin = results.rows[0];

      // Note: In a real-world scenario, use a secure password hashing mechanism like bcrypt
      if (admin.password === password) {
        req.session.adminID = admin.id;
        res.redirect("/home_admin");
      } else {
        req.flash("error", "Password is not correct");
        res.redirect("/admin_login");
      }
    } else {
      req.flash("error", "Email is not registered");
      res.redirect("/admin_login");
    }
  } catch (error) {
    console.error("Error during admin login:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = router;
