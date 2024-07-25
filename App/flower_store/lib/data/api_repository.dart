import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/services/https.service.dart';
import 'package:flower_store/models/invoice.dart';

class APIRepository {
  final Dio _dio = Dio();
  final HttpService _httpService = HttpService();

  APIRepository() {
    _dio.options.baseUrl = _httpService.headerUrl;
  }
  Future<List<Invoice>> getInvoicesByAccountId(String accountId) async {
    try {
      Response response = await _dio.get(
        '/Invoice/get-by-accountId/$accountId',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((invoice) => Invoice.fromJson(invoice as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load invoices: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        // print('Dio error type: ${e.type}');
        // print('Dio error message: ${e.message}');
        // if (e.response != null) {
        //   print('Dio error response data: ${e.response!.data}');
        //   print('Dio error response status code: ${e.response!.statusCode}');
        //   print('Dio error response headers: ${e.response!.headers}');
        // }
      }
      throw Exception('Failed to load invoices: $e');
    }
  }

  Future<List<Invoice>> getAllInvoices() async {
    try {
      Response response = await _dio.get(
        '/Invoice/getall-invoice',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((invoice) => Invoice.fromJson(invoice))
            .toList();
      } else {
        throw Exception('Failed to load invoices');
      }
    } catch (e) {
      throw Exception('Failed to load invoices: $e');
    }
  }

  Future<bool> updateProfile(AccountModel account) async {
    try {
      Response response = await _dio.post(
        '/Accounts/signup-update',
        data: account.toJson(),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Failed to update profile: $e');
      return false;
    }
  }

  Future<Invoice?> addNewInvoice(Map<String, dynamic> invoiceData) async {
    try {
      Response response = await _dio.post(
        '/Invoice/addnew-invoice',
        data: jsonEncode(invoiceData),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return Invoice.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw 'Tạo hóa đơn thất bại';
    }
  }
}
