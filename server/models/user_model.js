const Sequelize = require("sequelize");
const db = require("../config/db");
const bcrypt = require("bcryptjs");

const User = db.define("Users", {
    id: {
        type: Sequelize.STRING,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
    },
    name: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true,
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false,
        set(value) {
            const salt = bcrypt.genSaltSync(10);
            const hash = bcrypt.hashSync(value, salt);
            this.setDataValue("password", hash);
        },
    },
    project_ids: {
        type: Sequelize.ARRAY(Sequelize.STRING),
    }
});

module.exports = User;