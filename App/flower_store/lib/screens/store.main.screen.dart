import 'package:carousel_slider/carousel_slider.dart';
import 'package:flower_store/assets/custom_icon.dart';
import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/models/menu.model.dart';
import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/screens/favorite.screen.dart';
import 'package:flower_store/screens/user/profile.screen.dart';
import 'package:flower_store/screens/store_product_page/product_display.screen.dart';
import 'package:flower_store/services/product.service.dart';
import 'package:flower_store/shared/components/custom_drawer.dart';
import 'package:flower_store/shared/components/main_page_header.dart';
import 'package:flower_store/shared/widget/carousel.dart';
import 'package:flower_store/shared/widget/product.listview.horizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({super.key});

  @override
  State<StoreMainScreen> createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductService _productService = ProductService();
  final List<String> imgList = [
    'https://i.pinimg.com/originals/64/6b/ed/646bedb7a2bc011d01605cf84e5a4f90.jpg',
    'https://damasflowers.com/wp-content/uploads/2019/07/14-banner3-1.jpg',
    'https://assets.eflorist.com/site/EF-15879/Homepage/TODAYS%20DEALS%20BANNER%20WITH%20TITTLE.jpg',
    'https://img.teleflora.com/images/o_0/l_backgrounds:202002-DOTD_640LandingPage,pg_1/w_640,cs_no_cmyk,c_pad,g_south/f_auto,q_80,e_sharpen:1/backgrounds/202002-DOTD_640LandingPage/flowers'
  ];
  List<String> category = [
    "Bridal bouquet",
    "Bouquet",
    "Vase of flowers",
    "Basker of flowers",
    "Box of flowers",
    "Congratulation flowers",
    "Condolence flowers",
    "Tet flower collection",
  ];
  List<ProductModel> productsFavorite = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<ProductModel> productList = await _productService.getProductFavorite();
      setState(() {
        productsFavorite = productList;
      });
    } catch (e) {
      print('Lỗi khi tải sản phẩm: $e');
    }
  }

  Future<void> _navigateToProductDisplayScreen(ProductModel product) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDisplayScreen(product: product),
      ),
    );

    if (result != null && result is ProductModel) {
      _fetchProducts(); // Load lại dữ liệu khi quay trở lại
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: gradientBackground,
        ),
        child: Column(
          children: [
            mainPageHeader(_scaffoldKey, context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      ReusableCarousel(imageList: imgList),
                      ProductListview(
                        products: productsFavorite,
                        title: 'Đã thích',
                        navigator: const FavoriteScreen(),
                        seeAll: true,
                        onTap: _navigateToProductDisplayScreen,
                      ),
                      ProductListview(
                        products: products,
                        title: 'Bán nhiều nhất',
                        seeAll: true,
                        onTap: _navigateToProductDisplayScreen,
                      ),
                      ProductListview(
                        products: saleProducts,
                        title: 'Ưu đãi đặc biệt',
                        seeAll: true,
                        onTap: _navigateToProductDisplayScreen,
                      ),
                      ProductListview(
                        products: listProducts,
                        title: 'Hàng mới về',
                        seeAll: true,
                        onTap: _navigateToProductDisplayScreen,
                      ),
                      ProductListview(
                        products: products,
                        title: 'Được đánh giá cao',
                        seeAll: true,
                        onTap: _navigateToProductDisplayScreen,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  final List<ProductModel> products = [
    ProductModel(
      nameProduct: 'Blushing Bride',
      price: 560000,
      img:
          'https://product.hstatic.net/200000846175/product/z5544206552217_68cd21965416a9e4e15d838797fafb68-min_047147ebaacc456095f669d928b2052b_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Herves Love',
      price: 1000000,
      img:
          'https://product.hstatic.net/200000846175/product/_052e215d0bf4937c855e88d6d4b3e092-min_4ee2c7cf7ae24d67b1b46156d8b96f8c_bd89a4bf469c4db7833f9c3a51f8252e_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Rose Bouquet',
      price: 1200000,
      img:
          'https://product.hstatic.net/200000846175/product/4-min_d37e9a752bc145a4b6c407f01666a7d4_f60c9f31b2f947f285846b25733d2dc4_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Enchanted Dream',
      price: 4500000,
      img:
          'https://product.hstatic.net/200000846175/product/z5544206552196_c5c28d64ad14034f33bc540afd4fb6d6-min_e79665ef6dd247c3aed8e124e1576466_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
  ];

  final List<ProductModel> saleProducts = [
    ProductModel(
      nameProduct: 'Phoenix Rising',
      price: 2000000,
      img:
          'https://product.hstatic.net/200000846175/product/7a59a75a63acc1f298bd_b410dc34ad0542289a7aa01a1ac898c3_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Dancing Flames',
      price: 600000,
      img:
          'https://product.hstatic.net/200000846175/product/z5619438426641_b3fc1b52dea02f7ea9d1bd9cfa7b30e5_88f2ae44909341d2994eb4d89f0166c0_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Tropical Fiesta',
      price: 1200000,
      img:
          'https://product.hstatic.net/200000846175/product/z5585714112334_bcd9c83928e16e7b1f93006df9500d94-min__1__0938be19940c46b5a261fcf29ffd2a62_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'More Than Roes',
      price: 1200000,
      img:
          'https://product.hstatic.net/200000846175/product/untitled-1-01-min__1__0e2fa0a4a34248a99600cdba63b1ed64_1024x1024.png',
      fav: false,
      quantity: 10
    ),
  ];

  final List<ProductModel> listProducts = [
    ProductModel(
      nameProduct: 'Sunrise Serenade',
      price: 2000000,
      img:
          'https://product.hstatic.net/200000846175/product/1.5-min_51a78ed0c21d4bf3aed0d14fd6790e84_6bdcd2425e8e419d990e2f4eafded3e4_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Big Heart',
      price: 600000,
      img:
          'https://product.hstatic.net/200000846175/product/5-min_c1f605d2d445432ebfc23ed5dd28ddf9_2284b6b8669f4c9484be6cb44b444306_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Only you',
      price: 1200000,
      img:
          'https://product.hstatic.net/200000846175/product/3.5-min_f08ff68864a64b689534031b39598bf0_894a1c5188ce418a9dab6d485b4a8764_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
    ProductModel(
      nameProduct: 'Winer Wonderland',
      price: 1200000,
      img:
          'https://product.hstatic.net/200000846175/product/3-min_76730eac41a44540b8cf4009198043e6_aeae5de76eb44bb08fb2eb92daf41297_1024x1024.jpg',
      fav: false,
      quantity: 10
    ),
  ];
}
