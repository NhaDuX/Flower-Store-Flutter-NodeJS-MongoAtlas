const { Schema, model } = require('mongoose');

const CategorySchemaDoc = {
    $name: 'string',
}

const CategorySchema = new Schema({
    name: { type: String, required: true },
})

const CategoryModel = model('Categories', CategorySchema);
module.exports = { CategorySchemaDoc, CategoryModel };