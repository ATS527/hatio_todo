const express = require("express");
const bodyParser = require("body-parser");
require("dotenv").config();
const db = require("./config/db");
const cookieParser = require("cookie-parser");
const cors = require("cors");

const userRouter = require("./routes/user_routes");
const projectRouter = require("./routes/project_route");
const todoRouter = require("./routes/todo_routes");

const app = express();

app.use(express.json());
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));

app.use(cors({
    origin: ["http://localhost:5270", "http://127.0.0.1:5270", "http://locahost:8200", "http://127.0.0.1:8200"],
    credentials: true
}));

app.use("/api/v2", userRouter);
app.use("/api/v2", projectRouter);
app.use("/api/v2", todoRouter);

const PORT = process.env.PORT;

db.sync({ force: false }).then(() => {
    app.listen(PORT, () => {
        console.log(`Server started on port ${PORT}`);
    });
});