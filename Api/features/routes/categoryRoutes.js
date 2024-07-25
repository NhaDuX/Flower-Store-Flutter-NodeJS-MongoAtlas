const CategoryController = require("../controllers/category/category");

const GenericHttpResponse = require('../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const categoryController = new CategoryController();
const genericHttpResponse = new GenericHttpResponse();


router.post('/add-category', async (req, res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Add new category.',
            schema: { $ref: '#/definitions/Categories' }
        } 
        #swagger.responses[200] = { description: 'Add success', schema: true }
    */
    var result = await categoryController.NewCategory(req.body, res);
    if(result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});

router.get('/get-list-category', async (req, res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.responses[200] = { description: 'Get category list success', schema: { $ref: '#/definitions/Categories' } }
        #swagger.responses[500] = { description: 'Get category list failed', schema: 'error' }
    */
    var result = await categoryController.GetCategoryList(req, res);
    if(result != null) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/get-category-by-id/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Get category by id',
            required: true,
            type: 'string'
        }
        #swagger.responses[200] = { description: 'Get category success', schema: { $ref: '#/definitions/Categories' } }
        #swagger.responses[404] = { description: 'Category not found', schema: { message: 'string' } }
        #swagger.responses[500] = { description: 'Get category failed', schema: 'error' }
    */
    var result = await categoryController.GetCategoryById(req, res);
    if(result != null) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/find-category', async (req,res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Find category',
            schema: { $ref: '#/definitions/FindCategory' }
        } 
        #swagger.responses[200] = { description: 'Find success', schema: { $ref: '#/definitions/Categories' } }
        #swagger.responses[500] = { description: 'Find failt', schema: 'error' }
    */
    var result = await categoryController.FindCategory(req.body, res);
    if(result != null) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.put('/update-category/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Update category by id',
            required: true,
            type: 'string'
        }
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Update category data',
            schema: { $ref: '#/definitions/Categories' }
        } 
        #swagger.responses[200] = { description: 'Update success', schema: { $ref: '#/definitions/UpdateCategory' } }
        #swagger.responses[500] = { description: 'Update failed', schema: 'error' }
    */
    var result = await categoryController.UpdateCategory(req, res);
    if(result != null) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.delete('/delete-category/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Categories']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Delete category by id',
            required: true,
            type: 'string'
        }
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Update category data',
            schema: { $ref: '#/definitions/DeleteCategory' }
        } 
        #swagger.responses[200] = { description: 'Delete success', schema: true }
        #swagger.responses[500] = { description: 'Delete failed', schema: 'error' }
    */
    var result = await categoryController.DeleteCategory(req, res);
    if(result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});

module.exports = router;