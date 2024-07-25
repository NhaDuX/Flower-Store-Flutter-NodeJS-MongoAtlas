import 'dart:convert';
import 'package:flower_store/models/base.model.dart';

class AccountModel extends IBaseModel<AccountModel> {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String? accountID;

  AccountModel();

  @override
  void fromJsonMapping(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    accountID = json['_id'];
  }

  @override
  AccountModel fromJson(Map<String, dynamic> json) {
    fromJsonMapping(json);
    return this;
  }

  static AccountModel fromJsonStatic(Map<String, dynamic> json) {
    AccountModel accountModel = AccountModel();
    accountModel.fromJsonMapping(json);
    return accountModel;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['_id'] = accountID;
    return data;
  }
}
