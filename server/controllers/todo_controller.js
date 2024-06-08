const Todo = require("../models/todo_model");
const Project = require("../models/project_model");
const asyncHandler = require("../utils/asyncHandler");

exports.createTodo = asyncHandler(
    async (req, res) => {
        const {
            description,
            project_id
        } = req.body;

        const todoExists = await Todo.findOne({
            where: {
                description,
            },
        });

        if (todoExists) {
            return res.status(400).json({
                success: false,
                message: "Todo already exists",
            });
        }

        const todo = await Todo.create({
            description,
        });

        const project = await Project.findByPk(project_id);
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
                attributes: ["id", "description", "status", "updatedAt"],
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
        const { project_id, todo_id } = req.body;
        const project = await Project.findByPk(project_id);

        project.todos = project.todos.filter((todo) => todo !== todo_id);
        await project.save();

        const todo = await Todo.findByPk(todo_id);

        await todo.destroy();
        res.status(200).json({
            success: true,
            message: "Todo deleted",
        });
    }
);