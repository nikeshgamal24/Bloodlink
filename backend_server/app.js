const express = require("express");
const path = require("path");
const bodyParser = require('body-parser');
const hbs = require("hbs");
const app = express();
const authRouter = require("./routes/authToken");

//import Models
const adminRoute = require("./routes/adminRoute");
const userRoute = require("./routes/userRoute");
const campaignRoute = require("./routes/campaignRoute");
const requestRoute = require("./routes/requestRoute");

//PORT NUMBER
const port = process.env.PORT || 3000;

//Define Paths for hbs :Adarsh
const publicDirectoryPath = path.join(__dirname, "/public");
const viewsDirectoryPath = path.join(__dirname, "/templates/views");

app.use(bodyParser.urlencoded({
    extended: false
}));

app.use(bodyParser.json());


//Setup static directory :Adarsh
app.use(express.static(publicDirectoryPath));

//Setup  handlebar and views location and partials :Adarsh
app.set("view engine", "hbs");
app.set("views", viewsDirectoryPath);

app.listen(port, () => {
    console.log(`🚀:Server started on port ${port}`);
});

//Routes
app.use("/admin", adminRoute);
app.use("/user", userRoute);
app.use("/campaign", campaignRoute);
app.use("/request", requestRoute);

//based on the token after the login process
app.use(authRouter);

module.exports = app;