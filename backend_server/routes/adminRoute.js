const express = require("express");
const adminController = require("../controllers/adminController");

//Analogy can be : think as chaining method
const router = express.Router();

router.route("/").get(adminController.home);
router.route("/signup").post(adminController.signup);
router.route("/login").post(adminController.login);
router.route("/logout").get(adminController.protect, adminController.logout);
router.route("/adminPortal").get(adminController.protect, adminController.adminPortal);

//route for campaign information

//get unverified campaigns
router
    .route("/unverifiedCampaigns")
    .get(adminController.protect, adminController.unverifiedCampaigns);
//get all campaings
router
    .route("/allCampaigns")
    .get(adminController.protect, adminController.getAllCampaigns);

//route for user information
router
    .route("/unverifiedUsers")
    .get(adminController.protect, adminController.unverifiedUsers);

module.exports = router;