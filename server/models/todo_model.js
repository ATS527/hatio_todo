const Sequelize = require("sequelize");
const db = require("../config/db");

const Todo = db.define("Todos", {
    id: {
        type: Sequelize.STRING,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
    },
    description: {
        type: Sequelize.TEXT,
    },
    status: {
        type: Sequelize.BOOLEAN,
        defaultValue: false
    }
    //created_at and updated_at are created automatically by sequelize
});

module.exports = Todo;