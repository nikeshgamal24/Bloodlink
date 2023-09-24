const { promisify } = require("util");
const express = require("express");
const User = require("../models/userModel");
const getUserVerifyingToken = require("../controllers/getUserVerifyingToken");
const jwt = require("jsonwebtoken");
//Analogy can be : think as chaining method
const authRouter = express.Router();



//checking for the token // api to determine the token is valid
authRouter.post('/tokenIsValid', async(req, res) => {
    try {

        console.log('--------------index of x-auth-token--------')
            // headder index to obtain the token
        const headerIndex = req.rawHeaders.indexOf('x-auth-token');

        const token = req.rawHeaders[headerIndex + 1];

        console.log('inside /tokenIsValid route');
        console.log(`token :${token}`);
        tokenStatus = (token !== (null || undefined)) ? true : false
        console.log(tokenStatus);
        if (!token) {
            console.log('token not found')
            return res.json(false);
        }


        //we want to verify the token by using jwt.verify--> that will return the callback function and if done promisify it will be converted to the promises so for that we need to use the await that will return its value that can be stored and be checked 
        console.log("workign till jwt verification");

        const verified = jwt.verify(token, process.env.JWT_SECRET, {
            expiresIn: process.env.EXPIRES_IN,
        });

        // const verified = await promisify(jwt.verify)(token, process.env.JWT_SECRET);


        console.log(verified) //passwordKey---> is a public key
        if (!verified) {
            console.log("not verified");
            return res.json(false);
        }

        //is the user is available or not i.e. random token that is happened to be rue
        const user = await User.findById(verified.id);
        console.log(user);

        if (!user) {
            console.log(" not user");
            return res.json(false);
        }
        console.log("working fully");
        //if all passess
        res.json(true);
    } catch (error) {
        return res.status(500).json({
            error: error.message,
        });
    }
});


authRouter.get('/', getUserVerifyingToken.getUserByToken, async(req, res) => {
    try {
        console.log("inside get-->/ route ")
        console.log(req.user);
        const user = await User.findById(req.user);
        res.json({...user._doc, token: req.token });
    } catch (error) {
        return res.status(400).json({
            status: "Bad Request",
            message: error.message,
        });
    }

})

//exporting router
module.exports = authRouter;