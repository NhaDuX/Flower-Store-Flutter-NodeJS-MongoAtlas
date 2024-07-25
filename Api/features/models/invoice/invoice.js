const { Schema, model } = require('mongoose');

// Define the DetailInvoiceSchema as a sub-schema
const DetailInvoiceSchema = new Schema({
    productId: { type: String, required: true },
    product: { type: Schema.Types.ObjectId, required: true, ref: 'Product' },
    quantity: { type: Number, required: true },
    price: { type: Number, required: true },
    address: { type: String, required: true },
    date: { type: String, required: true },
});
const DetailInvoiceModel = model('DetailInvoice', DetailInvoiceSchema);
// module.exports = { DetailInvoiceModel };
// Define the InvoiceSchema
const InvoiceSchema = new Schema({
    nameInvoice: { type: String, required: true },
    details: [{ type: Schema.Types.ObjectId, ref: 'DetailInvoice' }],
    accountId: { type: String, required: true },
    account: { type: Schema.Types.ObjectId, ref: 'Accounts' }
});



const InvoiceModel = model('Invoice', InvoiceSchema);
module.exports = { InvoiceModel, DetailInvoiceModel };
