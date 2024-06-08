
const jwt = require("jsonwebtoken");
const User = require("../models/user_model");

exports.isAuthenticatedUser = async (req, res, next) => {
    var { token } = req.cookies;

    // adding this only for better code coverge in frontend
    if (!token) {
        token = req.headers.authorization;
    }

    if (!token) {
        return res.status(500).json({
            success: false,
            message: "Login first to access this resource",
        });
    }

    const decodedData = jwt.verify(token, process.env.JWT_SECRET_KEY);

    req.user = await User.findByPk(decodedData.id);

    next();
};