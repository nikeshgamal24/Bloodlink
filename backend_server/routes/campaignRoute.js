const express = require("express");
const authController = require("../controllers/authContoller");
const campaignController = require("../controllers/campaignController");

//Analogy can be : think as chaining method
const router = express.Router();

//create new campaign
router
    .route("/campaignForm")
    .post(authController.protect, campaignController.createCampaign);

//get all campaigns
router
    .route("/getCampaigns")
    .get(authController.protect, campaignController.getCampaigns);
//route is for admin and will provide the campaigns with unverified status
// router.route("/campaignVerfication").post(authController.login);




//exporting router
module.exports = router;