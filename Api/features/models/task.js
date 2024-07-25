const { Schema, model } = require('mongoose');
const app = require('D:\\Coding\\Flutter\\TestAppFlutter\\API\\app.js');

const taskSchema = new Schema({
    name: { type: String, required: true },
    createdDate: { type: Date, required: true },
    status: { type: Boolean, required: true }
})

const taskModel = model('Tasks', taskSchema);
module.exports = taskModel;
// module.exports = taskSchema;