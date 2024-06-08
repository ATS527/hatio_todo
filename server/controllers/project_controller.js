const Project = require('../models/project_model');
const User = require('../models/user_model');
const asyncHandler = require('../utils/asyncHandler');

exports.createProject = asyncHandler(
    async (req, res) => {

        const projectExists = await Project.findOne({
            where: {
                title: req.body.title,
            },
        });

        if (projectExists) {
            return res.status(400).json({
                success: false,
                message: "Project already exists",
            });
        }

        const project = await Project.create(req.body);

        await User.update(
            {
                project_ids: [...req.user.project_ids, project.id],
            },
            {
                where: { id: req.user.id },
            }
        );

        project.todos = [];
        await project.save();

        res.status(201).json({
            success: true,
            project,
        });
    }
);

exports.getUserProjects = asyncHandler(
    async (req, res) => {
        const userProjects = await User.findByPk(req.user.id,
            {
                attributes: ["project_ids"],
            }
        );

        if (userProjects.project_ids === null) {
            return res.status(200).json({
                success: true,
                project: [],
            });
        }

        const project = [];

        for (let i = 0; i < userProjects.project_ids.length; i++) {
            const projectOne = await Project.findByPk(userProjects.project_ids[i], {
                attributes: ["id", "title", "updatedAt", "todos"],
            });
            project.push(projectOne);
        }

        res.status(200).json({
            success: true,
            project: project,
        });
    }
);

exports.getProjectDetails = asyncHandler(
    async (req, res) => {
        const project = await Project.findByPk(req.params.id);
        res.status(200).json({
            success: true,
            project,
        });
    }
);

exports.updateProjectTitle = asyncHandler(
    async (req, res) => {
        const title = req.body.title;
        const project = await Project.findByPk(req.params.id);

        if (project === null) {
            return res.status(404).json({
                success: false,
                message: "Project not found",
            });
        }

        await project.update({
            title,
        });

        res.status(200).json({
            success: true,
            project,
        });
    }
);

exports.deleteProject = asyncHandler(
    async (req, res) => {
        const project = await Project.findByPk(req.params.id);

        if (project === null) {
            return res.status(404).json({
                success: false,
                message: "Project not found",
            });
        }

        await project.destroy();

        res.status(200).json({
            success: true,
            message: "Project deleted",
        });
    }
);