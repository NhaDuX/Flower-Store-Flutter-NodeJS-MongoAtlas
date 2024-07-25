const TaskController = require('./taskController');
const GenericHttpResponse = require('../../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const taskController = new TaskController();
const genericHttpResponse = new GenericHttpResponse();

router.get(`/get-list`, async (req, res) => {
    await taskController.getTaskList(req, res)
});
router.post('/save', async (req, res) => {
    const value = await taskController.SaveTask(req.body, res);
    console.log(value);
    if(value != null) genericHttpResponse.response(res, value);
    else genericHttpResponse.response(res, 'Error save task', false);
});

module.exports = router;