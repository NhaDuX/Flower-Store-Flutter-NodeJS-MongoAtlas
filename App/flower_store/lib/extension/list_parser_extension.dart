extension ListExtension<T> on List<T> {
  List<T> fromJson(
    List<dynamic> json, {
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    return json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }
}