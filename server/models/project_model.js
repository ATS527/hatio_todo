const Sequelize = require("sequelize");
const db = require("../config/db");

const Project = db.define("Projects", {
    id: {
        type: Sequelize.STRING,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
    },
    title: {
        type: Sequelize.STRING,
    },
    todos: {
        type: Sequelize.ARRAY(Sequelize.STRING),
    },
    created_at: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW,
    }
});

module.exports = Project;