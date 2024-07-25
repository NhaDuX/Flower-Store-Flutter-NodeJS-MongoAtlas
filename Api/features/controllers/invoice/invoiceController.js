const InvoiceService = require("../../services/invoiceService");
const invoiceService = new InvoiceService();

class InvoiceController {
    constructor() {}

    async NewInvoice(req, res) {
        return await invoiceService.NewInvoice( req.nameInvoice,req.details,req.productId,req.quantity,req.price,req.address,req.date,req.accountId);
    }

    async FindInvoice(req, res) {
        return await invoiceService.FindInvoice(req.accountId, res);
    }

   

    async GetInvoiceById(req, res) {
        const { id } = req.params;
        return  await invoiceService.GetInvoiceById(id);
        
    }

    async GetAllInvoices(req, res) {
        return await invoiceService.GetAllInvoices();
        
    }

    async GetInvoiceByAccountId(req, res) {
        const { accountId } = req.params;
        return  await invoiceService.GetInvoiceByAccountId(accountId);
        
    }
}
module.exports = InvoiceController;