import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/shared/widget/sorting.dropdown.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'product_card_favorite.dart';

class ProductGridview extends StatelessWidget {
  final List<ProductModel> products;
  final String title;
  final Function(String) onSortOptionChanged;

  ProductGridview({Key? key, required this.products, required this.title, required this.onSortOptionChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SortingDropdown(onSortOptionChanged: onSortOptionChanged),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}
