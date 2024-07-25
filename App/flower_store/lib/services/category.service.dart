import 'package:flower_store/models/category/category.model.dart';
import 'package:flower_store/services/https.service.dart';

class CategoryService {
  final HttpService _httpService = HttpService();

  Future<List<CategoryModel>> getAll() async {
    try {
      final response = await _httpService.dio.get('${_httpService.headerUrl}Categories/get-list-category');
      if (response.statusCode == 200) {
        List<CategoryModel> Categories = (response.data as List)
            .map((category) => CategoryModel.empty().fromJson(category))
            .toList();
        return Categories;
      } else {
        throw Exception('Không thể tải sản phẩm');
      }
    } catch (e) {
      throw Exception('Không thể tải sản phẩm: $e');
    }
  }
  
}
