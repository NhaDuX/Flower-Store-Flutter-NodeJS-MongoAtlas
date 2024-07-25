import 'package:flower_store/models/product/product.model.dart';

class DetailInvoice {
  final String id;
  final String productId;
  final ProductModel product;
  final int quantity;
  final int price;
  final String address;
  final String date;

  DetailInvoice({
    required this.id,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.price,
    required this.address,
    required this.date,
  });

  factory DetailInvoice.fromJson(Map<String, dynamic> json) {
    return DetailInvoice(
      id: json['_id'],
      productId: json['productId'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      price: json['price'],
      address: json['address'],
      date: json['date'],
    );
  }
}

class Invoice {
  final String id;
  final String nameInvoice;
  final List<DetailInvoice> details;
  final String accountId;

  Invoice({
    required this.id,
    required this.nameInvoice,
    required this.details,
    required this.accountId,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['_id'],
      nameInvoice: json['nameInvoice'],
      details: (json['details'] as List)
          .map((detail) => DetailInvoice.fromJson(detail))
          .toList(),
      accountId: json['accountId'],
    );
  }
}
