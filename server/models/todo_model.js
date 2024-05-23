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
    },
    created_at: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW,
    },
    updated_at: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW,
    },
});

module.exports = Todo;