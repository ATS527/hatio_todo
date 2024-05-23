const userRouter = require('express').Router();

const { isAuthenticatedUser, authorizeRoles } = require('../middlewares/auth');

const {
    createUser,
    loginUser,
    logoutUser,
    getUserProfile
} = require("../controllers/user_controller");

userRouter.post("/register", createUser);

userRouter.post("/login", loginUser);

userRouter.get("/logout", logoutUser);

userRouter.get("/me", isAuthenticatedUser, getUserProfile);

module.exports = userRouter;