import 'package:flower_store/models/base.model.dart';
import 'package:intl/intl.dart';

class CategoryModel extends IBaseModel<CategoryModel> {
  String? id; 
  late String name;

  CategoryModel({
    this.id, 
    required this. name
  });

  CategoryModel.empty();

  @override
  CategoryModel fromJson(Map<String, Object?> json) {
    return fromJsonMapping(json);
  }

  @override
  CategoryModel fromJsonMapping(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}
