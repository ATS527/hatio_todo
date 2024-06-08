const projectRouter = require('express').Router();

const {
    isAuthenticatedUser
} = require('../middlewares/auth');

const {
    createProject,
    getUserProjects,
    getProjectDetails,
    updateProjectTitle,
    deleteProject
} = require('../controllers/project_controller');

projectRouter.post('/createProject', isAuthenticatedUser, createProject);

projectRouter.get('/getUserProjects', isAuthenticatedUser, getUserProjects);

projectRouter.get('/getProjectDetails/:id', isAuthenticatedUser, getProjectDetails);

projectRouter.put('/updateProjectTitle/:id', isAuthenticatedUser, updateProjectTitle);

projectRouter.delete('/deleteProject/:id', isAuthenticatedUser, deleteProject);

module.exports = projectRouter;