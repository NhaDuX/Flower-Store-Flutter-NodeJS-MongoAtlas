import 'package:flower_store/models/base.model.dart';

class LoginModel extends IBaseModel {
  late String email;
  late String password;

  LoginModel();

  @override
  fromJson(Map<String, Object> json) => fromJsonMapping(json);

  @override
  fromJsonMapping(Map<String, dynamic> json) {
    // TODO: implement fromJsonMapping
    email = json['email'];
    password = json['password'];
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

}