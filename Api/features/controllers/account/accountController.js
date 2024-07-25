const AccountService = require("../../services/accountService");
const accountService = new AccountService();

class AccountController {
    constructor() {}

    async NewAccount(req, res) {
        return await accountService.NewAccount(req._id,req.name, req.email, req.phone, req.password);
    }

    async Login(req, res) {
        return await accountService.Login(req.email, req.password, res);
    }

    async GetList(res) {
        return await accountService.GetList(res);
    }

    async GetById(req, res) {
        return await accountService.GetById(req.params._id, res);
    }

    async delete(req, res) {
        return await accountService.delete(req.params._id, res);
    }
    async GetByEmail(req, res) {
        return await accountService.GetByEmail(req.params.email, res);
    }
}
module.exports = AccountController;