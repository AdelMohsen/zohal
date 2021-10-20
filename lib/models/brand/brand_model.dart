class BrandModel {
  int? success;
  List<BrandData> brandData = [];

  BrandModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    brandData = success != 0
        ? (json['data'] as List).map((e) => BrandData.fromJson(e)).toList()
        : [];
  }
}

class BrandData {
  String? brandDataId;
  String? brandName;
  String? brandPhotoUrl;

  BrandData.fromJson(Map<String, dynamic> json) {
    brandDataId = json['_id'];
    brandName = json['name'];
    brandPhotoUrl = json['photoUrl'];
  }
}
