const jwt = require("jsonwebtoken");
const User = require("../models/user_model");

const sendToken = (user, statusCode, res) => {
    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET_KEY, {
        expiresIn: process.env.JWT_EXPIRES * 60 * 60 * 24 * 1000,
    });

    const options = {
        expires: new Date(
            Date.now() + process.env.COOKIE_EXPIRE * 24 * 60 * 60 * 1000
        ),
        httpOnly: true,
        withCredentials: true,
        sameSite: "none",
        secure: true,
    };

    res.cookie('token', token, options);
    res.status(statusCode).send({ success: true, user, token });
}

module.exports = sendToken;