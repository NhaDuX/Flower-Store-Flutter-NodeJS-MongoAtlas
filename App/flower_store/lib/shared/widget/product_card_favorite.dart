import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/screens/store_product_page/product_display.screen.dart';
import 'package:flower_store/services/product.service.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final Widget? navigator;

  ProductCard({super.key, required this.product, this.navigator});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isFavorite;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.fav ?? false;
  }

  void toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
      widget.product.fav = isFavorite;
    });

    try {
      await _productService.toggleFavorite(widget.product.id!, isFavorite);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavorite
                ? 'Bạn đã thích sản phẩm ${widget.product.nameProduct}'
                : 'Bạn đã bỏ thích sản phẩm ${widget.product.nameProduct}',
          ),
        ),
      );
    } catch (e) {
      setState(() {
        isFavorite = !isFavorite;
        widget.product.fav = isFavorite;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra khi cập nhật trạng thái yêu thích: $e'),
        ),
      );
    }
  }

  Future<void> _navigateToProductDisplayScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDisplayScreen(product: widget.product),
      ),
    );

    if (result != null && result is ProductModel) {
      setState(() {
        widget.product.fav = result.fav;
        isFavorite = result.fav ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    widget.product.img,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: GestureDetector(
                    onTap: toggleFavorite,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _navigateToProductDisplayScreen,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(  // Sử dụng Center để căn giữa nội dung
                  child: Text(
                    widget.product.nameProduct,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(  
                child: Text(
                  '${widget.product.formattedPrice}đ',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
