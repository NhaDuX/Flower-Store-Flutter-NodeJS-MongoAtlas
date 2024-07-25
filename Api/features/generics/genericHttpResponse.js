class GenericHttpResponse {
    constructor() {}

    success(res, value) {
        return res.status(200).send(value);
    }

    fail(res, error) {
        return res.status(500).send(error);
    }
}
module.exports = GenericHttpResponse;