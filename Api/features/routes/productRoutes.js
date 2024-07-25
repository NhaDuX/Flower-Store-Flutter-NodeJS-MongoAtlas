const ProductController = require("../controllers/product/productController");

const GenericHttpResponse = require('../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const productController = new ProductController();
const genericHttpResponse = new GenericHttpResponse();

router.get('/find-product', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['nameProduct'] = {
            in: 'query',
            description: 'Search product by name',
            required: true,
            type: 'string'
        } 
        #swagger.responses[200] = { description: 'Find success ', schema: {$ref: '#/definitions/Products'} }
        #swagger.responses[500] = { description: 'Find Fail', schema: 'error' }
    */
    var result = await productController.FindProduct(req, res);
    if (result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/search-favorite-products', async (req, res) => {
    /*
        #swagger.tags = ['Product']
        #swagger.parameters['keyword'] = {
            in: 'query',
            description: 'Search favorite products by keyword',
            required: true,
            type: 'string'
        }
        #swagger.responses[200] = { description: 'Search success', schema: { $ref: '#/definitions/Products' } }
        #swagger.responses[500] = { description: 'Search fail', schema: 'error' }
    */
    var result = await productController.searchFavoriteProducts(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.post('/new-product', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Add new Product.',
            schema: { $ref: '#/definitions/Products' }
        } 
        #swagger.responses[200] = { description: 'New Products Success', schema: true }
    */
    var result = await productController.NewProduct(req.body, res);
    if(result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});

router.put('/update-product/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Update Product.',
            schema: { $ref: '#/definitions/Products' }
        } 
        #swagger.responses[200] = { description: 'Update Products Success', schema: true }
    */
    var result = await productController.UpdateProduct(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.delete('/delete-product/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Delete Product by ID.',
        } 
        #swagger.responses[200] = { description: 'Delete Products Success', schema: true }
    */
    var result = await productController.DeleteProduct(req, res);
    if(result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});

router.get('/getbyid-product/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Get Product by ID.',
        } 
        #swagger.responses[200] = { description: 'Get Product Success', schema: { $ref: '#/definitions/Products' } }
    */
    var result = await productController.GetProductById(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.post('/getall-product', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['ids'] = {
            in: 'path',
            description: 'Get Product by list of IDs.',
        }
        #swagger.responses[200] = { description: 'Get All Products Success', schema: { $ref: '#/definitions/Products' } }
    */
    var result = await productController.GetAllProducts(req.body, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/get-favorite-products', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.responses[200] = { description: 'Get Favorite Products Success', schema: { $ref: '#/definitions/Products' } }
    */
    var result = await productController.GetProductFavorite(req, res);
    if (result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
  });

  router.post('/toggle-favorite', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Toggle favorite status of a Product.',
            schema: { id: 'string', isFavorite: 'boolean' }
        }
        #swagger.responses[200] = { description: 'Toggle Favorite Success', schema: { $ref: '#/definitions/Products' } }
        #swagger.responses[500] = { description: 'Toggle Favorite Fail', schema: 'error' }
    */
    var result = await productController.toggleFavorite(req, res);
    if (result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});  

router.get('/get-products-by-category/:categoryId', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['categoryId'] = {
            in: 'path',
            description: 'Get Products by Category ID.',
        }
        #swagger.responses[200] = { description: 'Get Products by Category Success', schema: { $ref: '#/definitions/Products' } }
    */
    var result = await productController.getProductsByCategory(req, res);
    if (result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/search-products-by-category', async (req, res) => {
    /*
        #swagger.tags = ['Product']
        #swagger.parameters['categoryId'] = {
            in: 'query',
            description: 'Category ID',
            required: true,
            type: 'string'
        }
        #swagger.parameters['keyword'] = {
            in: 'query',
            description: 'Search keyword',
            required: true,
            type: 'string'
        }
        #swagger.responses[200] = { description: 'Search success', schema: { $ref: '#/definitions/Products' } }
        #swagger.responses[500] = { description: 'Search fail', schema: 'error' }
    */
    var result = await productController.searchProductsByCategory(req, res);
    if (result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/get-include-product-by-product-id/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Product']
        #swagger.parameters['ids'] = {
            in: 'path',
            description: 'Get Include product by parent product id',
        }
        #swagger.responses[200] = { description: 'Get Include Products Success', schema: { $ref: '#/definitions/Products' } }
    */
    var result = await productController.getIncludeProductByProId(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});
module.exports = router;