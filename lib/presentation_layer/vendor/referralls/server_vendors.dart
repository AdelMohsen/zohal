import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class MyServerVendors {
//   static Future<List<dynamic>> getList(Auth auth) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_LIST);
//
//       final request = await http.get(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//           'language': auth.language ?? '',
//         },
//       ).onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future<List<dynamic>> search(
//     Auth auth,
//     String query,
//     bool isOn,
//   ) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_SEARCH);
//
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//           'language': auth.language.toString(),
//         },
//         body: json.encode(
//           {
//             (isOn ? 'company' : 'email'): query,
//           },
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future<List<dynamic>> getProductsList({
//     required Auth auth,
//     String vendorId = '',
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_PRODUCTS);
//
//       Map<String, String> headers = {
//         'authorization': 'Bearer ${auth.token.toString()}',
//         'Content-Type': 'application/json',
//         'language': auth.language ?? '',
//       };
//
//       if (vendorId != '') {
//         headers['_id'] = vendorId;
//       }
//
//       final request = await http
//           .get(
//         url,
//         headers: headers,
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future<List<dynamic>> getOrdersList({
//     required Auth auth,
//     String vendorId = '',
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_ORDERS);
//
//       Map<String, String> headers = {
//         'authorization': 'Bearer ${auth.token.toString()}',
//         'Content-Type': 'application/json',
//         'language': auth.language ?? '',
//       };
//
//       if (vendorId != '') {
//         headers['_id'] = vendorId;
//       }
//
//       final request = await http
//           .get(
//         url,
//         headers: headers,
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }

//   static Future<String> addVendor({
//     required Auth auth,
//     required String firstName,
//     required String lastName,
//     required String company,
//     required String phone1,
//     required String phone2,
//     required String address1,
//     required String address2,
//     required String email,
//     required String password,
//     required Uint8List? imageBytes,
//     required String fileName,
//     required String fileMime,
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_ADD);
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             'firstName': firstName,
//             'lastName': lastName,
//             'company': company,
//             'phone1': phone1,
//             'phone2': phone2,
//             'address1': address1,
//             'address2': address2,
//           },
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//       final responseData = json.decode(request.body);
//
//       if (responseData['success'] == 0) {
//         throw responseData['message'];
//       } else {
//         if (imageBytes != null) {
//           await uploadImage(
//             auth: auth,
//             id: responseData['_id'],
//             imageBytes: imageBytes,
//             fileName: fileName,
//             fileMime: fileMime,
//           ).then((message) {
//             return [responseData['message'], message];
//           }).onError((error, stackTrace) {
//             print(stackTrace);
//             return [responseData['message'], error];
//           });
//         }
//       }
//       return responseData['message'];
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   static Future<String> updateVendor({
//     required Auth auth,
//     required Map<String, dynamic> updateMap,
//     required Map<String, dynamic>? imageMap,
//   }) async {
//     try {
//       if (updateMap.length > 1) {
//         final url = Uri.parse(MyServerConst.VENDORS_UPDATE);
//         final request = await http
//             .post(
//           url,
//           headers: {
//             'authorization': 'Bearer ${auth.token.toString()}',
//             'Content-Type': 'application/json',
//             'language': auth.language ?? '',
//           },
//           body: json.encode(
//             updateMap,
//           ),
//         )
//             .onError((error, stackTrace) {
//           print(stackTrace.toString());
//           throw error.toString();
//         });
//         final responseData = json.decode(request.body);
//
//         if (responseData['success'] == 0) {
//           throw responseData['message'];
//         } else {
//           if (imageMap != null)
//             return await uploadImage(
//               auth: auth,
//               id: updateMap['_id'],
//               imageBytes: imageMap['imageBytes'],
//               fileName: imageMap['fileName'],
//               fileMime: imageMap['fileMime'],
//             );
//         }
//
//         return responseData['message'];
//       } else {
//         return await uploadImage(
//           auth: auth,
//           id: updateMap['_id']!,
//           imageBytes: imageMap!['imageBytes'],
//           fileName: imageMap['fileName'],
//           fileMime: imageMap['fileMime'],
//         );
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   static Future<String> deleteVendor({
//     required Auth auth,
//     required String id,
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_DELETE);
//       final request = await http
//           .post(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//           'language': auth.language ?? '',
//         },
//         body: json.encode(
//           {
//             '_id': id,
//           },
//         ),
//       )
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData['success'] == 0) {
//         throw responseData['message'];
//       }
//
//       return responseData['message'];
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   static Future<String> uploadImage({
//     required Auth auth,
//     required String id,
//     required String fileName,
//     required String fileMime,
//     required Uint8List imageBytes,
//   }) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_UPLOAD);
//
//       final request = http.MultipartRequest('POST', url);
//
//       request.headers['authorization'] = 'Bearer ${auth.token.toString()}';
//       request.headers['_id'] = id;
//       request.headers['content-type'] = 'multipart/form-data';
//       request.headers['language'] = auth.language ?? '';
//
//       final mimeList = fileMime.split('/');
//       request.files.add(
//         http.MultipartFile.fromBytes(
//           'avatar',
//           imageBytes,
//           filename: fileName,
//           contentType: MediaType(mimeList[0], mimeList[1]),
//         ),
//       );
//
//       final response = await http.Response.fromStream(await request.send())
//           .onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(response.body);
//
//       if (responseData["success"] == 0) {
//         throw responseData['message'];
//       }
//
//       return responseData['message'];
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future<Map<String, dynamic>> getVendor(
//     Auth auth,
//   ) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_DOC);
//
//       final request = await http.get(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//           'language': auth.language ?? '',
//         },
//       ).onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future<Map<String, dynamic>> getVendorSubscription(
//     Auth auth,
//   ) async {
//     try {
//       final url = Uri.parse(MyServerConst.VENDORS_SUBSCRIPTION);
//
//       final request = await http.get(
//         url,
//         headers: {
//           'authorization': 'Bearer ${auth.token.toString()}',
//           'Content-Type': 'application/json',
//           'language': auth.language ?? '',
//         },
//       ).onError((error, stackTrace) {
//         print(stackTrace.toString());
//         throw error.toString();
//       });
//
//       final responseData = json.decode(request.body);
//       if (responseData["success"] == 0) {
//         throw '${responseData['message']}';
//       }
//
//       return responseData['data'];
//     } catch (e) {
//       throw e;
//     }
//   }
}
