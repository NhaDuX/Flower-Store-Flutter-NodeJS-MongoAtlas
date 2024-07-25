const AccountController = require("../controllers/account/accountController");

const GenericHttpResponse = require('../generics/genericHttpResponse');
const express = require('express');
const router = express.Router();

const accountController = new AccountController();
const genericHttpResponse = new GenericHttpResponse();


router.post('/signup-update', async (req, res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Add new user.',
            schema: { $ref: '#/definitions/Accounts' }
        } 
        #swagger.responses[200] = { description: 'Sign up success', schema: true }
    */
    var result = await accountController.NewAccount(req.body, res);
    if(result != null || result === true) genericHttpResponse.success(res, true);
    else genericHttpResponse.fail(res, result);
});


router.post('/login', async (req,res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Login.',
            schema: { $ref: '#/definitions/Login' }
        } 
        #swagger.responses[200] = { description: 'Login success', schema: { $ref: '#/definitions/Accounts' } }
        #swagger.responses[500] = { description: 'Login failt', schema: 'error' }
    */
    var result = await accountController.Login(req.body, res);
    return genericHttpResponse.success(res, result);
});

router.get('/get-list', async (req, res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.responses[200] = { description: 'Get list success', schema: { $ref: '#/definitions/Accounts' } }
        #swagger.responses[500] = { description: 'Get fail', schema: 'error' }
    */
   var result = await accountController.GetList(res);
   return genericHttpResponse.success(res, result);
});

router.get('/get-by-id/:_id', async (req, res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.responses[200] = { description: 'Get success', schema: { $ref: '#/definitions/Accounts' } }
        #swagger.responses[500] = { description: 'Get fail', schema: 'error' }
    */
   var result = await accountController.GetById(req, res);
   return genericHttpResponse.success(res, result)
})
router.delete('/delete/:_id', async (req, res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.responses[200] = { description: 'Delete success', schema: true }
        #swagger.responses[500] = { description: 'Delete fail', schema: 'error' }
    */
   var result = await accountController.delete(req, res);
   return genericHttpResponse.success(res, result)
})
router.get('/get-by-email/:email', async (req, res) => {
    /*  
        #swagger.tags = ['Accounts']
        #swagger.responses[200] = { description: 'Get success', schema: { $ref: '#/definitions/Accounts' } }
        #swagger.responses[500] = { description: 'Get fail', schema: 'error' }
    */
   var result = await accountController.GetByEmail(req, res);
   return genericHttpResponse.success(res, result)
})
module.exports = router;