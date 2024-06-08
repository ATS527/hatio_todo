const userRouter = require('express').Router();

const { isAuthenticatedUser, authorizeRoles } = require('../middlewares/auth');

const {
    createUser,
    loginUser,
    logoutUser,
    getUserProfile,
    deleteUser
} = require("../controllers/user_controller");

userRouter.post("/register", createUser);

userRouter.post("/login", loginUser);

userRouter.get("/logout", logoutUser);

userRouter.get("/me", isAuthenticatedUser, getUserProfile);

userRouter.delete("/deleteUser/:id", isAuthenticatedUser, deleteUser);

module.exports = userRouter;