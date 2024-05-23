const Project = require('../models/project_model');
const User = require('../models/user_model');
const asyncHandler = require('../utils/asyncHandler');

exports.createProject = asyncHandler(
    async (req, res) => {
        const project = await Project.create(req.body);
        if (req.user.project_ids === null) {
            req.user.project_ids = [];
        }
        await User.update(
            {
                project_ids: [...req.user.project_ids, project.id],
            },
            {
                where: { id: req.user.id },
            }
        );
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

        const projects = [];

        for (let i = 0; i < userProjects.project_ids.length; i++) {
            const project = await Project.findByPk(userProjects.project_ids[i], {
                attributes: ["id", "title"],
            });
            projects.push(project);
        }

        res.status(200).json({
            success: true,
            projects,
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