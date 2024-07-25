const DetailInvoiceService = require("../../services/detailInvoiceService");
const detailInvoiceService = new DetailInvoiceService();

class DetailInvoiceController {
    constructor() {}

    async NewDetailInvoice(req, res) {
        return await detailInvoiceService.NewDetailInvoice( req.productId,req.price,req.quantity,req.address,req.date);
    }


    async GetDetailInvoiceById(req, res) {
        const { id } = req.params;
        return  await detailInvoiceService.GetDetailInvoiceById(id);
        
    }

    async GetAllDetailInvoices(req, res) {
        return await detailInvoiceService.GetAllDetailInvoices();
        
    }
}
module.exports = DetailInvoiceController;