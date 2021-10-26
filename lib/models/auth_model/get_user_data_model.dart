class UserData {
  UserInfo? userInfo;

  UserData.fromJson(Map<String, dynamic> json) {
    userInfo = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
  }
}

class UserInfo {
  String id = '';
  int? type;
  String? email = '';
  String? firstName = 'visitor';
  String? lastName = "";
  String? phone1 = "";
  String? address = "";
  String? phone2 = "";
  String? address2 = "";
  String? photoUrl =
      "https://img.freepik.com/free-icon/important-person_318-10744.jpg?size=338&ext=jpg";
  List<Favourites> favourites = [];

  UserInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (type == 2) {
      id = json['_id'];
      email = json['email'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      phone1 = json['phone1'];
      address = json['address1'];
      phone2 = json['phone2'];
      address2 = json['address2'];
      photoUrl = json['photoUrl'];
     
    }
    if (type == 3) {
      id = json['_id'];
      email = json['email'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      phone1 = json['phone1'];
      address = json['address1'];
      phone2 = json['phone2'];
      address2 = json['address2'];
      photoUrl = json['photoUrl'];
      favourites = json['favourites'] != []
          ? (json['favourites'] as List)
              .map((e) => Favourites.fromJson(e))
              .toList()
          : [];
    }
  }
}

class Favourites {
  String? product;
  String? addedAt;
  Favourites.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    addedAt = json['addedAt'];
  }
}
