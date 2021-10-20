class UserData {
  UserInfo? userInfo;

  UserData.fromJson(Map<String, dynamic> json) {
    userInfo = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
  }
}

class UserInfo {
  String? id;
  int? type;
  String? email;
  String? firstName;
  String? lastName;
  String? phone1;
  String? address;
  String? phone2;
  String? address2;
  String? photoUrl;

  UserInfo.name(
      {this.email,
      this.firstName,
      this.lastName,
      this.address,
      this.address2,
      this.photoUrl});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone1 = json['phone1'];
    address = json['address1'];
    phone2 = json['phone2'];
    address2 = json['address2'];
    photoUrl = json['photoUrl'];
  }
}
