const express = require("express");
const authController = require("../controllers/authContoller");
const userController = require('../controllers/userController');

//Analogy can be : think as chaining method
const router = express.Router();

router.route("/signup").post(authController.signup);
router.route("/login").post(authController.login);
// router.route("/logout").get(authController.logout);'
router.route("/profile").get(authController.protect, userController.getProfile);

//user routes
// fetchAllUser
router.route("/get-users").get(authController.auth, userController.getAllUsers);


//exporting router
module.exports = router;