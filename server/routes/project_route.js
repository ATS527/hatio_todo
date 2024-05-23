const projectRouter = require('express').Router();

const {
    isAuthenticatedUser
} = require('../middlewares/auth');

const {
    createProject,
    getUserProjects,
    getProjectDetails
} = require('../controllers/project_controller');

projectRouter.post('/createProject', isAuthenticatedUser, createProject);

projectRouter.get('/getUserProjects', isAuthenticatedUser, getUserProjects);

projectRouter.get('/getProjectDetails/:id', isAuthenticatedUser, getProjectDetails);

module.exports = projectRouter;

