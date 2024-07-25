import 'package:flower_store/data/api_repository.dart';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/models/invoice.dart';
import 'package:flower_store/screens/cart/cart.screen.dart';
import 'package:flower_store/screens/cart/paymentmethod.screen.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/services/mail.service.dart';
import 'package:flower_store/services/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flower_store/models/cart.dart';

import 'package:flower_store/services/share_pre.dart';

class CheckoutPage extends StatefulWidget {
  final List<Cart> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final APIRepository _apiRepository = APIRepository();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  String addressLine1 = '';
  final TextEditingController _addressController = TextEditingController();

  void _editAddress() {
    _addressController.text = addressLine1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(hintText: 'Nhập địa chỉ'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  addressLine1 = _addressController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }

  Future<void> _handleCheckout() async {
    if(_addressController.text == '') {
      Fluttertoast.showToast(
        msg: "Vui lòng nhập địa chỉ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    else {
      String? accountId = await _sharedPreferencesService.getAccountID();
    AccountModel? account = await _sharedPreferencesService.getAccountInfo();

    if (accountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account ID not found')),
      );
      return;
    }
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final invoiceData = {
      "details": widget.cartItems.map((item) {
        return {
          "productId": item.productID,
          "quantity": item.quantity,
          "price": item.price,
          "address": _addressController.text ?? _addressController.text,
          "date": date,
        };
      }).toList(),
      "accountId": accountId,
    };

    _apiRepository.addNewInvoice(invoiceData)
    .then((invoice) {
      if (invoice != null) {
        String proList = '';
        int totalQuan = 0;
        int totalPrice = 0;
        for (var d in invoice.details) {
          proList = '''$proList 
            <tr>
              <td>${d.product.nameProduct}</td>
              <td>${d.quantity} cái</td>
              <td>${d.price} VND</td>
            </tr>
          ''';
          totalPrice += d.price;
          totalQuan += d.quantity;
        }
        sendEmail(account!.email, _emailTemplate(
          account.name, 
          _addressController.text, 
          date, 
          invoice.nameInvoice, 
          proList,
          totalQuan,
          totalPrice
        ), 'Đặt hàng thành công').then((onValue) => {});
        _databaseHelper.deleteProductAll();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentMethodPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create invoice')),
        );
      }
    });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.cartItems
        .fold(0, (sum, item) => sum + (item.price * item.quantity).toInt());

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
                      )),
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
                  label: const Text('Vận chuyển'),
                  selected: true,
                  onSelected: (bool selected) {},
                  selectedColor: Colors.pink[100],
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Thanh toán'),
                  selected: false,
                  onSelected: (bool selected) {},
                  selectedColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Địa chỉ giao hàng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _editAddress,
                  child: const Text('Sửa'),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(
                  addressLine1.isEmpty ? 'Chưa nhập địa chỉ' : addressLine1),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                  'Ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chi tiết đơn hàng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return ListTile(
                          title: Text('${item.name} (${item.quantity} cái)'),
                          trailing: Text(
                            '${formatCurrency(item.price * item.quantity)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        'Tổng',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        formatCurrency(total.toDouble()),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _handleCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff56789),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _emailTemplate(String name, String address, String date, String nameInvoice, String proList, int totalQuan, int totalPrice){
    return '''
<!DOCTYPE html>
<html>
<head>
  <style>
    .container {
      width: 100%;
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      font-family: Arial, sans-serif;
      color: #333;
    }
    .header {
      background-color: #f8d7da;
      color: #721c24;
      padding: 10px;
      text-align: left;
      border-radius: 8px 8px 0 0;
    }
    .header h1 {
      margin: 0;
      font-size: 18px;
    }
    .content {
      background-color: #f9f9f9;
      padding: 20px;
      border-radius: 0 0 8px 8px;
    }
    .content p {
      margin: 5px 0;
    }
    .item-table {
      width: 100%;
      border-collapse: collapse;
    }
    .item-table th, .item-table td {
      border: 1px solid #eaeaea;
      padding: 10px;
      text-align: left;
    }
    .total-row {
      font-weight: bold;
    }
    .footer {
      text-align: center;
      padding: 10px 0;
      background-color: #f1f1f1;
      margin-top: 20px;
      border-radius: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <p>Kính gửi $name,</p>
    <p>Cảm ơn vì đã mua hàng ở 4 MAN FLOWER, chúng tôi xin gửi bạn hóa đơn mua hàng:</p>
    <p>📍 <strong>Địa chỉ giao hàng:</strong> $address</p>
    <p>📅 <strong>Ngày đặt:</strong> $date</p>
    <div class="header">
      <h1>$nameInvoice</h1>
    </div>
    <div class="content">
      <table class="item-table">
        <tr>
          <th>Sản Phẩm</th>
          <th>Số Lượng</th>
          <th>Giá Tiền</th>
        </tr>
        $proList
        <tr class="total-row">
          <td>Tổng số lượng</td>
          <td>$totalQuan cái</td>
          <td></td>
        </tr>
        <tr class="total-row">
          <td>Tổng giá trị</td>
          <td></td>
          <td>$totalPrice VND</td>
        </tr>
      </table>
      <p>Mong bạn cảm thấy hài lòng với sản phẩm của chúng thôi.</p>
      <p>Xin trân trọng cảm ơn,<br>4 MAN FLOWER</p>
    </div>
    <div class="footer">
      <p>&copy; 2024 4 MAN FLOWER. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
''';
  }
}
