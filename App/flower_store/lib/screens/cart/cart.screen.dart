import 'package:flower_store/services/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flower_store/screens/cart/checkout.screen.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Cart> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    List<Cart> cartItems = await _databaseHelper.products();
    setState(() {
      items = cartItems;
      isLoading = false;
    });
  }

  void _incrementQuantity(Cart cartItem) async {
    await _databaseHelper.add(cartItem);
    _loadCartItems();
  }

  void _decrementQuantity(Cart cartItem) async {
    await _databaseHelper.minus(cartItem);
    _loadCartItems();
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 40,
                        left: 5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPageScreen(
                              isBack: true,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Giỏ hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        item.img,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style:
                                              const TextStyle(fontSize: 24.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          formatCurrency(
                                              item.price * item.quantity),
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () =>
                                                  _decrementQuantity(item),
                                            ),
                                            Text(
                                              item.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () =>
                                                  _incrementQuantity(item),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          cartItems: items,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff56789),
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                  ),
                  child: const Text(
                    'Thanh toán',
                    style: TextStyle(fontSize: 20, color: Color(0xffF0F0F0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
