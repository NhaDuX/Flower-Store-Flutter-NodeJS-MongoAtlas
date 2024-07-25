import 'package:flower_store/models/product/product.model.dart';
import 'package:flower_store/shared/widget/product_card_favorite.dart';
import 'package:flutter/material.dart';

class ProductListview extends StatelessWidget {
  final List<ProductModel> products;
  final String title;
  Widget? navigator;
  late bool? seeAll = true;
  final Function(ProductModel)? onTap;

  ProductListview({
    super.key,
    required this.products,
    required this.title,
    this.navigator,
    this.seeAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              seeAll != null && seeAll == true
                  ? TextButton(
                      onPressed: () {
                        if (navigator != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => navigator!));
                        }
                      },
                      child: const Text(
                        'Xem thêm',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap?.call(products[index]),
                child: Container(
                  width: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ProductCard(product: products[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
