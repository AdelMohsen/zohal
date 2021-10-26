// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:ecommerce/screens/login/web_login.dart';
// import 'package:ecommerce/util/other/my_utility.dart';
// import 'package:ecommerce/util/server/constants.dart';
// import 'package:ecommerce/util/server/util.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http_parser/http_parser.dart';

// class Auth with ChangeNotifier {
//   String? _token;
//   DateTime? _expiryDate;
//   Timer? _authTimer;
//   String? _userId;
//   int? _userType;
//   String? _language;
//   String? _firstName;
//   String? _lastName;
//   String? _email;
//   String? _photoUrl;
//   String? _phone;
//   String? _address;

//   String? _phone1;
//   String? _phone2;
//   String? _address1;
//   String? _address2;

//   bool get isAuth {
//     return token != null;
//   }

//   String? get token {
//     if (_expiryDate != null &&
//         _expiryDate!.isAfter(DateTime.now()) &&
//         _token != null) {
//       return _token;
//     }
//     return null;
//   }

//   String? get userId {
//     return _userId;
//   }

//   String? get firstName {
//     return _firstName;
//   }

//   void setFirstName(String newName) {
//     _firstName = newName;
//   }

//   String? get lastName {
//     return _lastName;
//   }

//   void setLastName(String newName) {
//     _lastName = newName;
//   }

//   String? get email {
//     return _email;
//   }

//   void setEmail(String newEmail) {
//     _email = newEmail;
//   }

//   int? get userType {
//     return _userType;
//   }

//   String? get photoUrl {
//     return _photoUrl;
//   }

//   void setPhotoUrl(String newPhotoUrl) {
//     _photoUrl = newPhotoUrl;
//   }

//   String? get phone {
//     return _phone;
//   }

//   void setPhone(String newPhone) {
//     _phone = newPhone;
//   }

//   String? get address {
//     return _address;
//   }

//   void setAddress(String newAddress) {
//     _address = newAddress;
//   }

//   String? get phone1 {
//     return _phone1;
//   }

//   void setPhone1(String newPhone) {
//     _phone1 = newPhone;
//   }

//   String? get address1 {
//     return _address1;
//   }

//   void setAddress1(String newAddress) {
//     _address1 = newAddress;
//   }

//   String? get phone2 {
//     return _phone2;
//   }

//   void setPhone2(String newPhone) {
//     _phone2 = newPhone;
//   }

//   String? get address2 {
//     return _address2;
//   }

//   void setAddress2(String newAddress) {
//     _address2 = newAddress;
//   }

//   String? get language {
//     return _language;
//   }

//   void setLanguage(String newLanguage) {
//     _language = newLanguage;
//   }

//   Future<void> login(String email, String password, String _udid) async {
//     try {
//       final url = Uri.parse(MyServerConst.LOGIN);

//       final request = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//           },
//         ),
//         headers: {
//           'Content-Type': 'application/json',
//           'language': _language ?? '',
//         },
//       ).onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });

//       final Map<String, dynamic> responseData = json.decode(request.body);

//       if (responseData['success'] == 0) {
//         throw '${responseData['message']}';
//       }

//       _token = responseData['token']['id'];
//       _expiryDate = DateTime.now().add(
//         Duration(
//           seconds: responseData['token']['expiresInSeconds'],
//         ),
//       );

//       _userId = responseData['user']['_id'];
//       _userType = responseData['user']['type'];
//       _firstName = responseData['user']['firstName'];
//       _lastName = responseData['user']['lastName'];
//       _email = responseData['user']['email'];
//       _photoUrl = MyServerConst.BASE_URL + responseData['user']['photoUrl'];
//       _language = responseData['user']['language'];

//       if (_userType == 0) {
//         _phone = responseData['user']['phone'];
//         _address = responseData['user']['address'];
//       } else if (_userType == 2) {
//         _phone1 = responseData['user']['phone2'];
//         _phone2 = responseData['user']['phone2'];
//         _address1 = responseData['user']['address1'];
//         _address2 = responseData['user']['address2'];
//       }

//       final prefs = await SharedPreferences.getInstance();
//       final userData = json.encode(
//         {
//           'token': _token,
//           'userId': _userId,
//           'userType': _userType,
//           'expiryDate': _expiryDate!.toIso8601String(),
//           'language': _language,
//         },
//       );

//       await prefs.setString('userData', userData);

//       _autoLogout();
//       notifyListeners();
//       Get.offNamedUntil(MyUtil.loginFlow(userType!), (route) => false);
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<bool> tryAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }

//     final extractedUserData =
//         json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

//     final expiryDate =
//         DateTime.parse(extractedUserData['expiryDate'] as String);

//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }

//     _token = extractedUserData['token'] as String;
//     _userId = extractedUserData['userId'] as String;
//     _userType = extractedUserData['userType'] as int;
//     _expiryDate = expiryDate;
//     _language = extractedUserData['language'] as String;

//     try {
//       await MyServerUtil.getUserProfile(this);
//       notifyListeners();
//       _autoLogout();
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     _userType = null;
//     _firstName = null;
//     _lastName = null;
//     _email = null;
//     _photoUrl = null;
//     _phone = null;
//     _address = null;
//     _phone1 = null;
//     _address1 = null;
//     _phone2 = null;
//     _address2 = null;
//     _language = null;

//     if (_authTimer != null) {
//       _authTimer!.cancel();
//       _authTimer = null;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();

//     Get.offAllNamed(WebLogin.routeName)!.then((_) {
//       Future.delayed(Duration(seconds: 4), () {
//         notifyListeners();
//       });
//     });
//   }

//   void _autoLogout() {
//     if (_authTimer != null) {
//       _authTimer!.cancel();
//     }
//     final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
//   }

//   Future<String> updateImage({
//     required Uint8List imageBytes,
//     required String fileMime,
//     required String fileName,
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.UPDATE_IMAGE);
//       final request = http.MultipartRequest('POST', url);

//       request.headers['authorization'] = 'Bearer $token';
//       request.headers['content-type'] = 'multipart/form-data';
//       request.headers['language'] = _language ?? '';

//       final mimeList = fileMime.split('/');
//       request.files.add(
//         http.MultipartFile.fromBytes(
//           'image',
//           imageBytes,
//           filename: fileName,
//           contentType: MediaType(mimeList[0], mimeList[1]),
//         ),
//       );

//       final response = await http.Response.fromStream(
//         await request.send(),
//       ).onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });

//       final responseData = json.decode(response.body);

//       if (responseData["success"] == 0) {
//         throw responseData['message'];
//       }

//       notifyListeners();
//       return responseData['message'];
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<String> updatePassword(String oldPassword, String newPassword) async {
//     try {
//       final url = Uri.parse(MyServerConst.UPDATE_PROFILE);
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'language': _language ?? '',
//         },
//         body: json.encode(
//           {
//             'passwords': {
//               'oldPassword': oldPassword,
//               'newPassword': newPassword,
//             },
//           },
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//       final responseData = json.decode(request.body);
//       if (responseData['success'] == 0) {
//         throw '${request.statusCode} : ${responseData['message']}';
//       }

//       return responseData['message'];
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<String> updateAdminProfile(Map<String, dynamic> updateMap) async {
//     try {
//       final url = Uri.parse(MyServerConst.UPDATE_PROFILE);
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'language': _language ?? '',
//         },
//         body: json.encode(
//           updateMap,
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//       final responseData = json.decode(request.body);
//       if (responseData['success'] == 0) {
//         throw responseData['message'];
//       }

//       if (updateMap['firstName'] != null) setFirstName(updateMap['firstName']);
//       if (updateMap['lastName'] != null) setLastName(updateMap['lastName']);
//       if (updateMap['email'] != null) setEmail(updateMap['email']);
//       if (updateMap['phone'] != null) setPhone(updateMap['phone']);
//       if (updateMap['address'] != null) setAddress(updateMap['address']);
//       if (updateMap['language'] != null) setLanguage(updateMap['language']);

//       notifyListeners();

//       return responseData['message'];
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<String> updateVendorProfile(Map<String, dynamic> updateMap) async {
//     try {
//       final url = Uri.parse(MyServerConst.UPDATE_PROFILE);
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'language': _language ?? '',
//         },
//         body: json.encode(
//           updateMap,
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//       final responseData = json.decode(request.body);
//       if (responseData['success'] == 0) {
//         throw responseData['message'];
//       }

//       if (updateMap['firstName'] != null) setFirstName(updateMap['firstName']);
//       if (updateMap['lastName'] != null) setLastName(updateMap['lastName']);
//       if (updateMap['email'] != null) setEmail(updateMap['email']);
//       if (updateMap['phone1'] != null) setPhone(updateMap['phone1']);
//       if (updateMap['phone2'] != null) setPhone(updateMap['phone2']);
//       if (updateMap['address1'] != null) setAddress(updateMap['address1']);
//       if (updateMap['address2'] != null) setAddress(updateMap['address2']);
//       if (updateMap['language'] != null) setLanguage(updateMap['language']);

//       notifyListeners();

//       return responseData['message'];
//     } catch (error) {
//       throw error;
//     }
//   }
// }
