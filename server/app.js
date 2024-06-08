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

const corsOptions = {
    origin: 'http://127.0.0.1:8200', // Specify the allowed origin
    credentials: true, // Allow credentials
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE', // Allowed methods
    allowedHeaders: 'Origin,X-Requested-With,Content-Type,Accept,Authorization', // Allowed headers
};

app.use(cors(corsOptions));

app.options('*', cors(corsOptions));

// Add headers before the routes are defined
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', 'http://localhost:8200'); // Update to match the origin you will make the request from
    res.header('Access-Control-Allow-Credentials', 'true');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    next();
});

app.use("/api/v2", userRouter);
app.use("/api/v2", projectRouter);
app.use("/api/v2", todoRouter);

const PORT = process.env.PORT;

db.sync({ force: false }).then(() => {
    app.listen(PORT, () => {
        console.log(`Server started on port ${PORT}`);
    });
});