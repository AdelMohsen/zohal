class CategoriesModel {
  int? success;
  List<CategoriesData>? categoriesData;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    categoriesData = success != 0
        ? (json['data'] as List).map((e) => CategoriesData.fromJson(e)).toList()
        : [];
  }
}

class CategoriesData {
  String? categoriesId;
  String? categoriesName;
  String? categoriesIconUrl;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    categoriesId = json['_id'];
    categoriesName = json['name'];
    categoriesIconUrl = json['iconUrl'];
  }
}
