import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/screens/cart/addpaymentmethodpage.screen.dart';
import 'package:flower_store/screens/store.main.screen.dart';
import 'package:flutter/material.dart';



class OrderSuccessfulPage extends StatefulWidget {
  @override
  _OrderSuccessfulPageState createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  void _continueShopping() {
    // Implement the continue shopping functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/order_successful.png', // Replace with your image URL
                  height: 400,
                ),
              ),
            ),
            const Text(
              'Đặt hàng thành công',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Đơn Hàng Của Bạn Đã Được Đặt Thành Công\nVà Đang Được Xử Lý Để Giao Hàng.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StoreMainScreen(),
                                  ),
                                );
                              },
              style: ElevatedButton.styleFrom(
                backgroundColor: iconColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Tiếp tục mua hàng',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
