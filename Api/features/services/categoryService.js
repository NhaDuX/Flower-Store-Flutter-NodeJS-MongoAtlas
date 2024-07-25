const {CategoryModel} = require('../models/category/category');

class CategoryService {
    constructor() {}

    async NewCategory(name) {
        try {
            const category = new CategoryModel({
                name
            });
            await category.save();
            return true;
        }
        catch(e) {
            return e;
        }
        return false;
    }

    async FindCategory(name) {
        try {
            var temp = await CategoryModel.findOne({name}).exec();
            return await CategoryModel.findOne({name}).exec();
        } 
        catch(e) {
            return res.status(500).send(e); 
        }
        return null;
    }

    async UpdateCategory(_id, updatedData) {
        try {
            const result = await CategoryModel.findByIdAndUpdate(_id, updatedData).exec();
            return result;
        } catch (e) {
            return e;
        }
    }

    async DeleteCategory(id) {
        try {
            await CategoryModel.findByIdAndDelete(id).exec();
            return true;
        } catch (e) {
            return e;
        }
    }

    async GetCategoryList() {
        try {
            return await CategoryModel.find().exec();
        } catch (e) {
            return e;
        }
    }

    async GetCategoryById(id) {
        try {
            return await CategoryModel.findById(id).exec();
        } catch (e) {
            return e;
        }
    }
}
module.exports = CategoryService;