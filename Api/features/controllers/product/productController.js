const ProductService = require("../../services/productService");
const productService = new ProductService();

class ProductController {
    constructor() {}

    async NewProduct(req, res) {
        return await productService.NewProduct( req.nameProduct, req.price, req.img,req.quantity,req.descrip,req.cateid,req.inclueId);
    }

    async FindProduct(req, res) {
        const { nameProduct } = req.query;
        return await productService.FindProduct(nameProduct, res);
    }

    async UpdateProduct(req, res) {
        const { id } = req.params;
        const updateData = req.body;
        return await productService.UpdateProduct(id, updateData);
    }

    async DeleteProduct(req, res) {
        
        const { id } = req.params;
        
        return await productService.DeleteProduct(id);
    }

    async GetProductById(req, res) {
        const { id } = req.params;
        return await productService.GetProductById(id);
    }

    async GetAllProducts(req, res) {
        return await productService.GetAllProducts(req.ids, req.cateIds);
    }

    async GetProductFavorite(req, res) {
        return await productService.GetProductFavorite();
    }

    async toggleFavorite(req, res) {
        const { id, isFavorite } = req.body;
        return await productService.toggleFavorite(id, isFavorite);
    }

    async getProductsByCategory(req, res) {
        const { categoryId } = req.params;
        return await productService.getProductsByCategory(categoryId);
    }

    async searchFavoriteProducts(req, res) {
        const { keyword } = req.query;
        return await productService.searchFavoriteProducts(keyword);
    }

    async searchProductsByCategory(req, res) {
        const { categoryId, keyword } = req.query;
        return await productService.searchProductsByCategory(categoryId, keyword);
    }

    async getIncludeProductByProId(req, res) {
        return await productService.GetAllIncludeProducts(req.params.id);
    }
}
module.exports = ProductController;