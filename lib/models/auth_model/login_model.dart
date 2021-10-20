class UserLogin {
  int? success;
  String? message;
  LoginToken? token;
  UserDataFromLogin? userDataFromLogin;

  UserLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = success == 0 ? json['message'] : '';
    token = json['token'] != null ? LoginToken.fromJson(json['token']) : null;
    userDataFromLogin =
        json['user'] != null ? UserDataFromLogin.fromJson(json['user']) : null;
  }
}

class LoginToken {
  int? expiresInSeconds;
  String? id;
  LoginToken.fromJson(Map<String, dynamic> json) {
    expiresInSeconds = json['expiresInSeconds'];
    id = json['id'];
  }
}

class UserDataFromLogin {
  String? userId;
  int? type;
  String? email;
  String? firstName;
  String? lastName;
  String? phone1;
  String? phone2;
  String? address1;
  String? address2;
  String? photoUrl;
  String? language;

  UserDataFromLogin.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    type = json['type'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    address1 = json['address1'];
    address2 = json['address2'];
    photoUrl = json['photoUrl'];
    language = json['language'];
  }
}
