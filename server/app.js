const express = require("express");
const bodyParser = require("body-parser");
const db = require("./config/db");
require("dotenv").config();
const path = require("path");
const cookieParser = require("cookie-parser");
const cors = require("cors");

const userRouter = require("./routes/user_routes");

const app = express();

app.use(express.json());
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));

app.use(cors());

app.use("/api/v2", userRouter);

db.sync().then(() => {
    app.listen(5270, () => {
        console.log("Server started on port 3000");
    });
});