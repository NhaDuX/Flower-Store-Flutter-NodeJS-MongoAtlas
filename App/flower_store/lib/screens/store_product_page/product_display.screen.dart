import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/models/cart.dart';
import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/screens/cart/cart.screen.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/services/product.service.dart';
import 'package:flower_store/services/sqlite.dart';
import 'package:flower_store/shared/widget/product.listview.horizontal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDisplayScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDisplayScreen({super.key, required this.product});

  @override
  State<ProductDisplayScreen> createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends State<ProductDisplayScreen> {
  final GlobalKey _key = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final ProductService _productService = ProductService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool _isPriceCardFixed = false;
  late bool liked;
  late ProductModel product;
  late double originalPrice;
  int quantity = 1;
  double screenHeight = 1000;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    liked = widget.product.fav ?? false;
    originalPrice = product.price;
    _scrollController.addListener(_scrollListener);

    if(includeProducts.isEmpty) _getIncludeProduct();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double startY = offset.dy;

    setState(() {
      _isPriceCardFixed = startY <= (screenHeight * 30 / 100);
    });
    debugPrint(_isPriceCardFixed.toString());
  }

  void toggleFavorite() async {
    setState(() {
      liked = !liked;
      product.fav = liked;
    });

    try {
      await _productService.toggleFavorite(product.id!, liked);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            liked
                ? 'Bạn đã thích sản phẩm ${product.nameProduct}'
                : 'Bạn đã bỏ thích sản phẩm ${product.nameProduct}',
          ),
        ),
      );
    } catch (e) {
      setState(() {
        liked = !liked;
        product.fav = liked;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra khi cập nhật trạng thái yêu thích: $e'),
        ),
      );
    }
  }

  String getFormattedPrice(double price) {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(price);
  }

  Future<void> _addToCart() async {
    await _databaseHelper.insertProduct(Cart(
      productID: product.id!,
      name: product.nameProduct,
      price: product.price,
      img: product.img,
      address: 'Default Address', // Replace with actual address
      des: product.descrip ?? '',
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      quantity: quantity,
    ));
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MainPageScreen(
                currentScreen: CartPage(),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    debugPrint((screenHeight * 35 / 100).toString());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFFF0F0F0)),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                  top: screenHeight * 35 / 100 +
                      (_isPriceCardFixed ? screenHeight * 5 / 100 : 0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(product.nameProduct,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        if (!_isPriceCardFixed) priceCard(),
                        if (product.descrip != null) description(),
                        ProductListview(
                          products: includeProducts,
                          title: 'Sản phẩm bao gồm',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: _addToCart,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff56789),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 15),
                              ),
                              child: const Text(
                                'Thêm vào giỏ hàng',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: header(),
          ),
          if (_isPriceCardFixed)
            Positioned(
              top: screenHeight * 35 / 100,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: priceCard(),
              ),
            ),
        ],
      ),
    );
  }

  Container header() {
    return Container(
      width: double.infinity,
      height: screenHeight * 35 / 100,
      decoration: const BoxDecoration(
          color: softPink,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
      child: Padding(
        padding: EdgeInsets.only(
            left: 16, right: 16, top: screenHeight * 5 / 100, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context, product),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: product.img.contains('https://')
                  ? Image.network(
                      product.img,
                    )
                  : Image.asset(
                      product.img,
                    ),
            ),
            IconButton(
              icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
                  color: liked ? Colors.red : Colors.grey),
              onPressed: toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }

  Card priceCard() {
    return Card(
      key: _key,
      margin: _isPriceCardFixed
          ? EdgeInsets.zero
          : const EdgeInsets.only(bottom: 10, top: 10),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('  ${getFormattedPrice(product.price)} vnđ',
              style: const TextStyle(fontSize: 20, color: Colors.red)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => setState(() {
                  if (quantity > 1) {
                    quantity--;
                  }
                  product.price = originalPrice * quantity;
                }),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.red),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() {
                  if (quantity < product.quantity) {
                    quantity++;
                  }
                  product.price = originalPrice * quantity;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: SizedBox(
        height: screenHeight * 15 / 100,
        child: SingleChildScrollView(
          child:
              Text('${product.descrip}', style: const TextStyle(fontSize: 17)),
        ),
      ),
    );
  }

  List<ProductModel> includeProducts = [];

  _getIncludeProduct() {
    if(product.id != null) {
      _productService.getIncludeProductById(product.id!)
      .then((onValue) {
        if(onValue.isNotEmpty) {
          setState(() {
            includeProducts = onValue;
          });
        }
      });
    }
  }
}
