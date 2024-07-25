import 'package:flower_store/models/authorize/login.model.dart';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/services/https.service.dart';

class AuthorizeService {
  final HttpService _httpService = HttpService();
  final String controller = 'Accounts';

  constructor() {
    
  }
  Future<bool> signup(AccountModel model) =>
    _httpService.post<AccountModel, bool>(('$controller/signup-update'), model);

  Future<AccountModel> login(LoginModel model) => 
    _httpService.post<LoginModel, AccountModel>('$controller/login', model, returnType: AccountModel());

  Future<AccountModel> getById(String _id) => 
    _httpService.get<LoginModel, AccountModel>('$controller/get-by-id/$_id', AccountModel());
    
  Future<AccountModel> getByEmail(String email) async {
    try {
      final response = await _httpService.dio.get('${_httpService.headerUrl}Accounts/get-by-email/$email');
      if (response.statusCode == 200 && response.data is Map) {
        // Map<String, Object> stringObjectMap = response.data.map(
        //   (key, value) {
        //     if (key is! String) {
        //       throw ArgumentError('All keys must be of type String');
        //     }
        //     if (value is! Object) {
        //       throw ArgumentError('All values must be of type Object');
        //     }
        //     return MapEntry(key, value);
        //   },
        // );
        return AccountModel().fromJson(response.data);
      } else {
        throw Exception('Email không tồn tại');
      }
    } catch (e) {
      throw Exception('Email không tồn tại: $e');
    }
  }
}