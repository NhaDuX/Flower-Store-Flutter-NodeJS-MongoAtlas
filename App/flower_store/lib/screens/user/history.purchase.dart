import 'package:dio/dio.dart';
import 'package:flower_store/services/share_pre.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/invoice.dart';
import '../../data/api_repository.dart';
import '../../models/authorize/signup.model.dart';

class HistoryPurchaseScreen extends StatefulWidget {
  const HistoryPurchaseScreen({Key? key}) : super(key: key);

  @override
  _HistoryPurchaseScreenState createState() => _HistoryPurchaseScreenState();
}

class _HistoryPurchaseScreenState extends State<HistoryPurchaseScreen> {
  final APIRepository apiRepository = APIRepository();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  List<Invoice> invoices = [];
  String selectedSortOption = 'Sắp Xếp';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    try {
      final accountId = await sharedPreferencesService.getAccountID();
      if (accountId != null) {
        final fetchedInvoices =
            await apiRepository.getInvoicesByAccountId(accountId);
        setState(() {
          invoices = fetchedInvoices; // Assign the list of invoices
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Account ID not found in SharedPreferences');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //print('Failed to load invoices: $e');
      // if (e is DioException) {
      //   print('Dio error message: ${e.message}');
      //   print('Dio error response: ${e.response}');
      // }
    }
  }

  void sortPurchaseHistory(String criteria) {
    setState(() {
      switch (criteria) {
        case 'Sắp Xếp':
          invoices.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 'Ngày':
          invoices.sort((a, b) {
            DateTime dateA = a.details.isNotEmpty
                ? DateFormat('dd-MM-yyyy').parse(a.details[0].date)
                : DateTime.now();
            DateTime dateB = b.details.isNotEmpty
                ? DateFormat('dd-MM-yyyy').parse(b.details[0].date)
                : DateTime.now();
            return dateA.compareTo(dateB);
          });
          break;
        case 'Giá':
          invoices.sort((a, b) {
            int totalPriceA = a.details
                .fold(0, (sum, item) => sum + item.price * item.quantity);
            int totalPriceB = b.details
                .fold(0, (sum, item) => sum + item.price * item.quantity);
            return totalPriceA.compareTo(totalPriceB);
          });
          break;
        case 'A-Z':
          invoices.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 'Z-A':
          invoices.sort((a, b) => b.id.compareTo(a.id));
          break;
        default:
          break;
      }
    });
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử mua hàng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xffF0F0F0),
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          Row(
            children: [
              const SizedBox(width: 20),
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffFA6C6C),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: DropdownButton<String>(
                    value: selectedSortOption,
                    dropdownColor: const Color(0xffFA6C6C),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSortOption = newValue;
                          sortPurchaseHistory(selectedSortOption);
                        });
                      }
                    },
                    items: <String>[
                      'Sắp Xếp',
                      'Ngày',
                      'Giá',
                      'A-Z',
                      'Z-A',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: invoices.length,
                      itemBuilder: (context, index) {
                        final invoice = invoices[index];
                        int totalQuantity = invoice.details
                            .fold(0, (sum, item) => sum + item.quantity);
                        int totalPrice = invoice.details.fold(
                            0, (sum, item) => sum + item.price * item.quantity);
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  padding:
                                      const EdgeInsets.only(top: 17, left: 20),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromARGB(255, 229, 207, 212),
                                        Color.fromARGB(255, 243, 203, 212),
                                        Color(0xffFF85A1)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    invoice.nameInvoice,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16),
                                        Text(
                                          'Địa chỉ giao hàng',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 38, top: 4),
                                  child: Text(invoice.details.isNotEmpty
                                      ? invoice.details[0].address
                                      : 'Không có địa chỉ'),
                                ),
                                const SizedBox(height: 8.0),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 4),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 16),
                                      const SizedBox(width: 4.0),
                                      Text(invoice.details.isNotEmpty
                                          ? invoice.details[0].date
                                          : 'Không có ngày'),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: invoice.details.length,
                                    itemBuilder: (context, itemIndex) {
                                      final item = invoice.details[itemIndex];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${item.product.nameProduct} (${item.quantity} cái)'),
                                            Text(
                                                '${formatCurrency(item.price)} '),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Tổng số lượng'),
                                          Text('$totalQuantity cái'),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Tổng tiền'),
                                          Text(
                                              '${formatCurrency(totalPrice)} '),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
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
          ),
        ],
      ),
    );
  }
}
