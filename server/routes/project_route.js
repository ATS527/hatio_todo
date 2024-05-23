const projectRouter = require('express').Router();

const {
    isAuthenticatedUser
} = require('../middlewares/auth');

const {
    createProject,
    getUserProjects,
    getProjectDetails,
    updateProjectTitle
} = require('../controllers/project_controller');

projectRouter.post('/createProject', isAuthenticatedUser, createProject);

projectRouter.get('/getUserProjects', isAuthenticatedUser, getUserProjects);

projectRouter.get('/getProjectDetails/:id', isAuthenticatedUser, getProjectDetails);

projectRouter.put('/updateProjectTitle/:id', isAuthenticatedUser, updateProjectTitle);

module.exports = projectRouter;

