const DetailInvoiceController = require("../controllers/invoice/detailInvoiceController");

const GenericHttpResponse = require('../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const detailInvoiceController = new DetailInvoiceController();
const genericHttpResponse = new GenericHttpResponse();


router.post('/addnew-detailInvoice', async (req, res) => {
    /*  
        #swagger.tags = ['DetailInvoice']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Add new DetailInvoice.',
            schema: { $ref: '#/definitions/DetailInvoices' }
        } 
        #swagger.responses[200] = { description: 'New DetailInvoices Success', schema: true }
    */
    var result = await detailInvoiceController.NewDetailInvoice(req.body, res);
    if(result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});



router.get('/getbyid-detailInvoice/:id', async (req, res) => {
    /*  
        #swagger.tags = ['DetailInvoice']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Get DetailInvoice by ID.',
        } 
        #swagger.responses[200] = { description: 'Get DetailInvoice Success', schema: { $ref: '#/definitions/DetailInvoices' } }
    */
    var result = await detailInvoiceController.GetDetailInvoiceById(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/getall-detailInvoice', async (req, res) => {
    /*  
        #swagger.tags = ['DetailInvoice']
        #swagger.responses[200] = { description: 'Get All DetailInvoices Success', schema: { $ref: '#/definitions/DetailInvoices' } }
    */
    var result = await detailInvoiceController.GetAllDetailInvoices(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

module.exports = router;