import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/screens/cart/addpaymentmethodpage.screen.dart';
import 'package:flower_store/screens/cart/cart.screen.dart';
import 'package:flower_store/screens/cart/checkout.screen.dart';
import 'package:flower_store/screens/cart/order.succesful.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';

import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final List<Map<String, dynamic>> paymentCards = [
    {
      'type': 'Visa',
      'number': '**** **** **** 1234',
      'color1': Colors.pink[800],
      'color2': Colors.pink[200],
    },
    {
      'type': 'Mastercard',
      'number': '**** **** **** 1234',
      'color1': Colors.purple[800],
      'color2': Colors.purple[200],
    },
  ];

  void _editCard() {
    // Implement the edit functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPageScreen(
                  currentScreen: CartPage(),
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Vận Chuyển'),
                  selected: false,
                  onSelected: (bool selected) {},
                  selectedColor: Colors.grey[300],
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Thanh toán'),
                  selected: true,
                  onSelected: (bool selected) {},
                  selectedColor: Colors.pink[100],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paymentCards.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          paymentCards[index]['color1'],
                          paymentCards[index]['color2']
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Credit Card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddPaymentMethodPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          paymentCards[index]['type'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          paymentCards[index]['number'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text(
                  'Thực hiện thanh toán',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
