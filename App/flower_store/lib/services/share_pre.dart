import 'dart:convert';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_store/models/authorize/login.model.dart';

class SharedPreferencesService {
  static const String _accountInfoKey = 'accountInfo';
  static const String _prevLoginInfoKey = 'prevLoginInfo';

  // Save account information to SharedPreferences
  Future<void> saveAccountInfo(AccountModel account) async {
    final prefs = await SharedPreferences.getInstance();
    String accountJson = jsonEncode(account.toJson());
    await prefs.setString(_accountInfoKey, accountJson);
    print("Saved accountInfo: $accountJson");
  }

  // Retrieve account information from SharedPreferences
  Future<AccountModel?> getAccountInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? accountJson = prefs.getString(_accountInfoKey);
    if (accountJson != null) {
      Map<String, dynamic> accountMap = jsonDecode(accountJson);
      return AccountModel.fromJsonStatic(accountMap);
    }
    return null;
  }

  // Retrieve only accountID from SharedPreferences
  Future<String?> getAccountID() async {
    final prefs = await SharedPreferences.getInstance();
    String? accountJson = prefs.getString(_accountInfoKey);
    if (accountJson != null) {
      Map<String, dynamic> accountMap = jsonDecode(accountJson);
      return accountMap['_id'];
    }
    return null;
  }

  Future<void> saveLoginInfo(String accountId, bool save) async {
    final prefs = await SharedPreferences.getInstance();
    String prevLoginInfoJson = jsonEncode({'accountId': accountId, 'save': save});
    await prefs.setString(_prevLoginInfoKey, prevLoginInfoJson);
  } 

  Future<String?> checkPrevSaveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? prevLoginInfoJson = prefs.getString(_prevLoginInfoKey);
    if(prevLoginInfoJson != null) {
      Map<String, dynamic> map = jsonDecode(prevLoginInfoJson);
      return map['save'] as bool ? map['accountId'] : null;
    }
    return null;
  }
}
