const {DetailInvoiceModel} = require('../models/invoice/detailInvoice');

class DetailInvoiceService {
    constructor() {}

    async NewDetailInvoice(productId,price,quantity,address,date) {
        try {
            const detailInvoice = new DetailInvoiceModel({
                productId,price,quantity,address,date
            });
            await detailInvoice.save();
            return true;
        }
        catch(e) {
            return e;
        }
        return false;
    }



   
    
    async GetDetailInvoiceById(id) {
        try {
            const detailInvoice = await DetailInvoiceModel.findById(id).exec();
            return detailInvoice;
        } catch (e) {
            return e;
        }
    }

    async GetAllDetailInvoices() {
        try {
            const detailInvoices = await DetailInvoiceModel.find().exec();
            return detailInvoices;
        } catch (e) {
            return e;
        }
    }

   

}
module.exports = DetailInvoiceService;