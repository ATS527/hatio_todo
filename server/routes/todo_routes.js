const todoRouter = require('express').Router();

const {
    isAuthenticatedUser
} = require('../middlewares/auth');

const {
    createTodo,
    getProjectTodos,
    updateTodo,
    deleteTodo
} = require('../controllers/todo_controller');

todoRouter.post('/createTodo', isAuthenticatedUser, createTodo);

todoRouter.get('/getProjectTodos/:id', isAuthenticatedUser, getProjectTodos);

todoRouter.put('/updateTodo/:id', isAuthenticatedUser, updateTodo);

todoRouter.delete('/deleteTodo', isAuthenticatedUser, deleteTodo);

module.exports = todoRouter;