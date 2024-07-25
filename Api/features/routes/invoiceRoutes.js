const InvoiceController = require("../controllers/invoice/invoiceController");

const GenericHttpResponse = require('../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const invoiceController = new InvoiceController();
const genericHttpResponse = new GenericHttpResponse();

router.post('/find-invoice',async(req,res)=>{
    /*  
        #swagger.tags = ['Invoice']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Find invoice',
            schema: { $ref: '#/definitions/FindInvoice' }
        } 
        #swagger.responses[200] = { description: 'Find success ', schema: {$ref: '#/definitions/Invoices'} }
        #swagger.responses[500] = { description: 'Find Fail', schema: 'error' }
    */
        return invoiceController.FindInvoice(req.body, res);
})
router.post('/addnew-invoice', async (req, res) => {
    /*  
        #swagger.tags = ['Invoice']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Add new Invoice.',
            schema: { $ref: '#/definitions/Invoices' }
        } 
        #swagger.responses[200] = { description: 'New Invoices Success', schema: '#/definitions/Invoices' }
    */
    var result = await invoiceController.NewInvoice(req.body, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});



router.get('/getbyid-invoice/:id', async (req, res) => {
    /*  
        #swagger.tags = ['Invoice']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Get Invoice by ID.',
        } 
        #swagger.responses[200] = { description: 'Get Invoice Success', schema: { $ref: '#/definitions/Invoices' } }
    */
    var result = await invoiceController.GetInvoiceById(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/getall-invoice', async (req, res) => {
    /*  
        #swagger.tags = ['Invoice']
        #swagger.responses[200] = { description: 'Get All Invoices Success', schema: { $ref: '#/definitions/Invoices' } }
    */
    var result = await invoiceController.GetAllInvoices(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

router.get('/get-by-accountId/:accountId', async (req, res) => {
    /*  
        #swagger.tags = ['Invoice']
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'Get Invoice by ID.',
        } 
        #swagger.responses[200] = { description: 'Get Invoice Success', schema: { $ref: '#/definitions/Invoices' } }
    */
    var result = await invoiceController.GetInvoiceByAccountId(req, res);
    if(result) genericHttpResponse.success(res, result);
    else genericHttpResponse.fail(res, result);
});

module.exports = router;