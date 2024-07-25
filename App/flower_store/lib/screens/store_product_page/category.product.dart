import 'package:dio/dio.dart';
import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/services/product.service.dart';
import 'package:flower_store/shared/components/custom_drawer.dart';
import 'package:flower_store/shared/components/input_decoration.dart';
import 'package:flower_store/shared/components/main_page_header.dart';
import 'package:flower_store/shared/widget/product.grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductService _productService = ProductService();
  List<ProductModel> products = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

void _sortProducts(String sortOption) {
    setState(() {
      if (sortOption == 'A-Z') {
        products.sort((a, b) => a.nameProduct.compareTo(b.nameProduct));
      } else if (sortOption == 'Z-A') {
        products.sort((a, b) => b.nameProduct.compareTo(a.nameProduct));
      } else if (sortOption == 'Giá, thấp đến cao') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Giá, cao đến thấp') {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  Future<void> _fetchProducts() async {
    try {
      List<ProductModel> productList = await _productService.getProductsByCategory(widget.categoryId);
      setState(() {
        products = productList;
      });
    } catch (e) {
      print('Lỗi khi tải sản phẩm: $e');
    }
  }

  Future<void> _searchProducts(String keyword) async {
    try {
      List<ProductModel> productList = await _productService.searchProductsByCategory(widget.categoryId, keyword);
      setState(() {
        products = productList;
      });
    } catch (e) {
      print('Lỗi khi tìm kiếm sản phẩm: $e');
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
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 16, right: 16),
              child: genericFieldContainer(
                field: FormBuilderTextField(
                  controller: _searchController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onTap: () {},
                  name: 'search',
                  decoration: genericInputDecoration(
                    label: 'Tìm kiếm',
                    prefixIcon: Icons.search,
                  ),
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      _searchProducts(value);
                    } else {
                      _fetchProducts();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: ProductGridview(
                products: products,
                title: widget.categoryName,
                onSortOptionChanged: _sortProducts,
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
