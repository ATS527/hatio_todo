const Sequelize = require("sequelize");

//since it is local database we are not storing it in .env file
const db = new Sequelize("hatio_todos", "ats527", "strongPassword", {
    host: "localhost",
    dialect: "postgres",
});

module.exports = db;