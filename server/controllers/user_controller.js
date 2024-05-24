const User = require("../models/user_model");
const asyncHandler = require("../utils/asyncHandler");
const sendToken = require("../utils/jwtToken");
const bcrypt = require("bcryptjs");

exports.createUser = asyncHandler(
    async (req, res) => {
        const { email } = req.body;

        const userExists = await User.findOne({ where: { email } });

        if (userExists) {
            return res.status(500).json({
                success: false,
                message: "User already exists",
            });
        }

        const user = await User.create(req.body);
        sendToken(user, 200, res);
    }
);

exports.loginUser = asyncHandler(
    async (req, res) => {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(500).json({
                success: false,
                message: "Please enter email and password",
            });
        }

        const user = await User.findOne({ where: { email } });

        if (!user) {
            return res.status(500).json({
                success: false,
                message: "User not found",
            });
        }

        const isPasswordMatched = bcrypt.compareSync(password, user.password);

        if (!isPasswordMatched) {
            return res.status(500).json({
                success: false,
                message: "Invalid email or password",
            });
        }

        sendToken(user, 200, res);
    }
);

exports.logoutUser = asyncHandler(
    async (req, res) => {
        res.cookie("token", null, {
            expires: new Date(Date.now()),
            httpOnly: true,
        });

        res.status(200).json({
            success: true,
            message: "Logged out",
        });
    }
);

exports.getUserProfile = asyncHandler(
    async (req, res) => {
        res.status(200).json({
            success: true,
            user: req.user,
        });
    }
);