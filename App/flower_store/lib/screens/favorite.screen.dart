import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/services/product.service.dart';
import 'package:flower_store/shared/components/custom_drawer.dart';
import 'package:flower_store/shared/components/input_decoration.dart';
import 'package:flower_store/shared/components/main_page_header.dart';
import 'package:flower_store/shared/widget/product.grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ProductModel> productsFavorite = [];
  final ProductService _productService = ProductService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

void _sortProducts(String sortOption) {
    setState(() {
      if (sortOption == 'A-Z') {
        productsFavorite.sort((a, b) => a.nameProduct.compareTo(b.nameProduct));
      } else if (sortOption == 'Z-A') {
        productsFavorite.sort((a, b) => b.nameProduct.compareTo(a.nameProduct));
      } else if (sortOption == 'Giá, thấp đến cao') {
        productsFavorite.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Giá, cao đến thấp') {
        productsFavorite.sort((a, b) => b.price.compareTo(a.price));
      }
    });
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

  Future<void> _searchFavoriteProducts(String keyword) async {
    try {
      List<ProductModel> productList = await _productService.searchFavoriteProducts(keyword);
      setState(() {
        productsFavorite = productList;
      });
    } catch (e) {
      print('Lỗi khi tìm kiếm sản phẩm yêu thích: $e');
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
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              mainPageHeader(_scaffoldKey, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: genericFieldContainer(
                  field: FormBuilderTextField(
                    controller: _searchController,
                    onTapOutside: (event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onTap: () {},
                    name: 'Search',
                    decoration: genericInputDecoration(
                      label: 'Tìm kiếm',
                      prefixIcon: Icons.search,
                    ),
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        _searchFavoriteProducts(value);
                      } else {
                        _fetchProducts();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ProductGridview(
                  products: productsFavorite,
                  title: 'Đã thích',
                  onSortOptionChanged: _sortProducts,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
