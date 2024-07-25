abstract class IBaseModel<T> {
  IBaseModel();
  Map<String, dynamic> toJson();
  T fromJson(Map<String, Object> json);
  fromJsonMapping(Map<String, dynamic> json);
}