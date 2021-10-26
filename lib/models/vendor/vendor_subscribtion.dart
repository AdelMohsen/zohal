class SubScribtionModel {
  int? success;
  List<SubScribtionData>? subScribtionData;

  SubScribtionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success == 1) {
      subScribtionData =(json['data'] as List).isNotEmpty ?
       (json['data'] as List)
          .map((e) => SubScribtionData.fromJson(e))
          .toList() : [];
    }
  }
}

class SubScribtionData {
  String id = '';
  String name = '';
  String days = '';
  String price = '';
  String createdBy = '';
  int v = 0;
  String updatedAt = '';

  SubScribtionData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    days = json['days'];
    price = json['price'];
    createdBy = json['createdBy'];
    v = json['__v'];
    updatedAt = json['updatedAt'];
  }
}
