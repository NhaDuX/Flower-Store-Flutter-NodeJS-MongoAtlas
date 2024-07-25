import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatefulWidget {
  @override
  _OrderSuccessScreenState createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/order_successful.png',
                ),
              ),
            ),
            const Text(
              'Đặt hàng thành công',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'Đơn Hàng Của Bạn Đã Được Đặt Thành Công\nVà Đang Được Xử Lý Để Giao Hàng.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPageScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: iconColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: const Text(
                'Tiếp tục mua hàng',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
