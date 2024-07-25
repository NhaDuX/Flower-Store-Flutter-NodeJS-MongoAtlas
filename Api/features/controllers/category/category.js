const CategoryService = require("../../services/categoryService");
const categoryService = new CategoryService();

class CategoryController {
    constructor() {}

    async NewCategory(req, res) {
        return await categoryService.NewCategory(req.name);
    }

    async FindCategory(req, res) {
        return await categoryService.FindCategory(req.name, res);
    }
    
    async UpdateCategory(req, res) {
        const updatedData = req.body;
        return await categoryService.UpdateCategory(req.params._id, updatedData);
    }

    async DeleteCategory(req, res) {
        return await categoryService.DeleteCategory(req.params.id);
    }

    async GetCategoryList(req, res) {
        return await categoryService.GetCategoryList();
    }

    async GetCategoryById(req, res) {
        return await categoryService.GetCategoryById(req.params.id);    
    }
}
module.exports = CategoryController;