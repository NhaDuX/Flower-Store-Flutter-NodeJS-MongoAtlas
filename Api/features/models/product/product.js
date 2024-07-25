const { Schema, model } = require('mongoose');

const ProductSchemaDoc = {
    
    $nameProduct: 'string',
    $price: 'number',
    $img: 'string',
    $quantity: 'number',
    $descrip: 'string',
    $inclueId: 'string',
    $fav: 'boolean',
    $cateid: 'string'
   
}

const ProductSchema = new Schema({
    
    nameProduct: { type: String, required: true },
    price: { type: Number, required: true },
    img: { type: String, required: true },
    quantity: { type: Number, required: true },
    descrip: { type: String },
    inclueId: [{ type: Schema.Types.ObjectId, ref: 'Product' }],
    fav: { type: Boolean },
    cateid: { type: String, required: true },
})


const ProductModel = model('Product', ProductSchema);
module.exports = { ProductSchemaDoc, ProductModel };