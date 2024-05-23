const Todo = require("../models/todo_model");
const Project = require("../models/project_model");
const asyncHandler = require("../utils/asyncHandler");

exports.createTodo = asyncHandler(
    async (req, res) => {
        const {
            description,
            project_id
        } = req.body;
        const todo = await Todo.create({
            description,
        });

        const project = await Project.findByPk(project_id);
        if (project.todos === null) {
            project.todos = [];
        }
        await project.update(
            {
                todos: [...project.todos, todo.id],
            }
        );
        res.status(201).json({
            success: true,
            todo,
        });
    }
);

exports.getProjectTodos = asyncHandler(
    async (req, res) => {
        const projectTodos = await Project.findByPk(req.params.id, {
            attributes: ["todos"],
        });

        const todos = [];

        for (let i = 0; i < projectTodos.todos.length; i++) {
            const todo = await Todo.findByPk(projectTodos.todos[i], {
                attributes: ["id", "description", "status"],
            });
            todos.push(todo);
        }

        res.status(200).json({
            success: true,
            todos,
        });
    }
);

exports.updateTodo = asyncHandler(
    async (req, res) => {
        const { description, status } = req.body;
        const todo = await Todo.findByPk(req.params.id);
        await todo.update(
            {
                description,
                status,
            }
        );
        res.status(200).json({
            success: true,
            message: "Todo updated",
            todo
        });
    }
);

exports.deleteTodo = asyncHandler(
    async (req, res) => {
        const todo = await Todo.findByPk(req.params.id);
        await todo.destroy();
        res.status(200).json({
            success: true,
            message: "Todo deleted",
        });
    }
);