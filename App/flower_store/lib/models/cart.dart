import 'dart:convert';

class Cart {
  String productID;
  String name;
  double price;
  String address;
  String des;
  String date;
  int quantity;
  String img;
  //constructor
  Cart({
    required this.name,
    required this.price,
    required this.address,
    required this.des,
    required this.date,
    required this.quantity,
    required this.productID,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'des': des,
      'address': address,
      'date': date,
      'productId': productID,
      'img': img,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productID: map['productID'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      date: map['date'] ?? '',
      des: map['des'] ?? '',
      address: map['address'] ?? '',
      quantity: map['quantity'] ?? 0,
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() =>
      'Product(productID: $productID, name: $name, price: $price, quantity: $quantity, des: $des, date: $date, address: $address,img: $img)';
}
