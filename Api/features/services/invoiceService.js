const {InvoiceModel, DetailInvoiceModel} = require('../models/invoice/invoice');

class InvoiceService {
    constructor() {}

    async NewInvoice(nameInvoice,details,productId,quantity,price,address,date,accountId) {
        try {
            let newDetailIds = new Array;
            if(details != null && details instanceof Array) {
                for (let index = 0; index < details.length; index++) {
                    const element = details[index];
                    const {productId,quantity,price,address,date} = element;

                    let detail = new DetailInvoiceModel({productId,quantity,price,address,date, product: productId});
                    var newDetail = await detail.save();
                    newDetailIds.push(newDetail._id);
                }
                
            }
            const i = await InvoiceModel.find().exec();
            nameInvoice = `HD${i.length + 1}`;
            const invoice = new InvoiceModel({
                nameInvoice,details: newDetailIds,productId,quantity,price,address,date,accountId,account: accountId
            });
            const res = await invoice.save();
            return await this.GetInvoiceById(res._id);
        }
        catch(e) {
            return e;
        }
        return false;
    }

    async FindInvoice( accountId, res) {
        try {
            var temp = await InvoiceModel.findOne({ accountId}).exec();
            return await InvoiceModel.findOne({ accountId}).exec();
        } 
        catch(e) {
            return res.status(500).send(e); 
        }
        return null;
    }

    
    
    async GetInvoiceById(id) {
        try {
            const invoice = await InvoiceModel.findById(id).populate('account').populate({path: 'details', populate: {path: 'product'}}).exec();
            return invoice;
        } catch (e) {
            return e;
        }
    }

    async GetAllInvoices() {
        try {
            const invoices = await InvoiceModel.find().populate('account').populate({path: 'details', populate: {path: 'product'}}).exec();
            return invoices;
        } catch (e) {
            return e;
        }
    }

    async GetInvoiceByAccountId(accountId) {
        try {
            const invoice = await InvoiceModel.find({accountId}).populate('account').populate({path: 'details', populate: {path: 'product'}}).exec();
            return invoice;
        } catch (e) {
            return e;
        }
    }
}
module.exports = InvoiceService;