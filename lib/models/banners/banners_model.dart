class BannersModel {
  int? success;
  List<BannersData> data = [];

  BannersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? (json['data'] as List).map((e) => BannersData.fromJson(e)).toList()
        : [];
  }
}

class BannersData {
  String? bannersDataId;
  String? days;
  String? endTimeStamp;
  String? bannerUrl;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? v;
  BannersDataVendor? vendor;

  BannersData.fromJson(Map<String, dynamic> json) {
    bannersDataId = json['_id'];
    days = json['days'];
    endTimeStamp = json['endTimestamp'];
    bannerUrl = json['bannerUrl'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    vendor = json['vendor'] != null
        ? BannersDataVendor.fromJson(json['vendor'])
        : null;
  }
}

class BannersDataVendor {
  String? bannersVendorId;
  String? vendorCompany;

  BannersDataVendor.fromJson(Map<String, dynamic> json) {
    bannersVendorId = json['_id'];
    vendorCompany = json['company'];
  }
}
