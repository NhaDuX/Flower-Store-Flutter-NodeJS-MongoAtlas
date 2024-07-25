const TaskService = require('../../services/taskService');
const taskService = new TaskService();

class TaskController {
    constructor() {}

    async getTaskList(req, res) {
        taskService.getList()
        .then((value) => {
            res.status(200).send(value);
        })
        .catch((err) => console.log(err));
    }
    
    async SaveTask(req, res) {
        return await taskService.save(req._id, req.name, req.status);
    }
}
module.exports = TaskController;
