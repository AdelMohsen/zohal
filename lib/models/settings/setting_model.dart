class SettingModel {
  int? success;
  SettingData? data;

  SettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SettingData.fromJson(json['data']) : null;
  }
}

class SettingData {
  String? settingDataId;
  String? currency;

  SettingData.fromJson(Map<String, dynamic> json) {
    settingDataId = json['_id'];
    currency = json['currency'];
  }
}
