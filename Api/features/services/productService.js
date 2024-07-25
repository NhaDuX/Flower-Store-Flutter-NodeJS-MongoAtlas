const {ProductModel} = require('../models/product/product');

class ProductService {
    constructor() {}

    async NewProduct( nameProduct, price, img,quantity,descrip,cateid,inclueId) {
        try {
            const product = new ProductModel({
                 nameProduct, price, img,quantity,descrip,cateid,inclueId
            });
            await product.save();
            return true;
        }
        catch(e) {
            return e;
        }
        return false;
    }

    async FindProduct(nameProduct, res) {
        try {
            const products = await ProductModel.find({
                nameProduct: { $regex: nameProduct, $options: 'i' }
            }).populate('inclueId').exec();
            return products;
        } catch (e) {
            return res.status(500).send(e);
        }
    }

    async UpdateProduct(id, updateData) {
        try {
            const product = await ProductModel.findByIdAndUpdate(id, updateData, { new: true });
            return product;
        } catch (e) {
            return res.status(500).send(e); 
        }
    }

    async DeleteProduct(id) {
        try {
            await ProductModel.findByIdAndDelete(id);
            return true;
        } catch (e) {
            return e;
        }
    }
    
    async GetProductById(id) {
        try {
            const product = await ProductModel.findById(id).populate('inclueId').exec();
            return product;
        } catch (e) {
            return e;
        }
    }

    async GetAllProducts(ids, cateIds) {
        try {
            // const products = ids != null && ids instanceof Array
            // ? await ProductModel.find({
            //         _id: { $in: ids },

            //     }).exec() 
            // : await ProductModel.find().exec();
            // return products;
            let query = {};

            if(ids != null && ids instanceof Array && ids.length > 0) 
                query._id = { $in: ids }
            if(cateIds != null && cateIds instanceof Array && cateIds.length > 0) 
                query.cateid = { $in: cateIds }

            return await ProductModel.find(query).populate('inclueId').exec();
        } catch (e) { 
            return e;
        }
    }

    async GetProductFavorite() {
        try {
          const favoriteProducts = await ProductModel.find({ fav: true }).exec();
          return favoriteProducts;
        } catch (e) {
          throw new Error(e);
        }
      }
    async toggleFavorite(id, isFavorite) {
        try {
            const product = await ProductModel.findByIdAndUpdate(
                id,
                { fav: isFavorite },
                { new: true }
            ).exec();
            return product;
        } catch (e) {
            throw new Error('Không thể cập nhật trạng thái yêu thích: ' + e.message);
        }
    }

    async getProductsByCategory(categoryId) {
        try {
            const products = await ProductModel.find({ cateid: categoryId }).exec();
            return products;
        } catch (e) {
            throw new Error('Không thể lấy danh sách sản phẩm theo thể loại: ' + e.message);
        }
    }

    async searchFavoriteProducts(keyword) {
        try {
            const products = await ProductModel.find({
                nameProduct: { $regex: keyword, $options: 'i' },
                fav: true
            }).exec();
            return products;
        } catch (e) {
            throw new Error('Không thể tìm kiếm sản phẩm yêu thích: ' + e.message);
        }
    }

    async searchProductsByCategory(categoryId, keyword) {
        try {
            const products = await ProductModel.find({
                cateid: categoryId,
                nameProduct: { $regex: keyword, $options: 'i' }
            }).exec();
            return products;
        } catch (e) {
            throw new Error('Không thể tìm kiếm sản phẩm theo thể loại: ' + e.message);
        }
    }

    async GetAllIncludeProducts(id) {
        try {
            const pros = await ProductModel.findById(id).populate('inclueId').exec();
            return pros.inclueId;
        } catch (e) { 
            return e;
        }
    }
}
module.exports = ProductService;