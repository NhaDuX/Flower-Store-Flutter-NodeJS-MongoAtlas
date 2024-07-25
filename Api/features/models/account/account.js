const { Schema, model } = require('mongoose');

const AccountSchemaDoc = {
    $name: 'string',
    $email: 'string',
    $phone: 'string',
    $password: 'string'
}

const AcountSchema = new Schema({
    name: { type: String, required: true },
    email: { type: String, required: true },
    phone: { type: String, required: true },
    password: {type: String, required: true }
})

const AccountModel = model('Accounts', AcountSchema);
module.exports = { AccountSchemaDoc, AccountModel };