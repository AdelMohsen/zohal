import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:zohal/constance/strings.dart';
import 'dart:convert';

import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class MyServerAds {
  static Future<List<dynamic>> getList(int? index) async {
    try {
      final url = Uri.parse(MyServerConst.ADS_LIST);

      final request = await http.get(url, headers: {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'language': lang ?? '',
        '_id': index.toString(),
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(request.body);
      if (responseData["success"] == 0) {
        throw '${responseData['message']}';
      }

      return responseData['data'];
    } catch (e) {
      throw e;
    }
  }

  static Future<String> addAd({
    required String days,
    required String position,
    required String vendorId,
    required Uint8List? imageBytes,
    required String fileName,
    required String fileMime,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.ADS_ADD);
      final request = await http
          .post(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
        },
        body: json.encode(
          {
            'days': days,
            'vendorId': vendorId,
            'position': position,
          },
        ),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });
      final responseData = json.decode(request.body);
      if (responseData['success'] == 0) {
        throw responseData['message'];
      } else {
        if (imageBytes != null) {
          await uploadImage(
            id: responseData['_id'],
            imageBytes: imageBytes,
            fileName: fileName,
            fileMime: fileMime,
          ).then((message) {
            return [responseData['message'], message];
          }).onError((error, stackTrace) {
            print(stackTrace);
            return [responseData['message'], error];
          });
        }
      }

      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<String> updateAd({
    required Map<String, dynamic> updateMap,
    Map<String, dynamic>? imageMap,
  }) async {
    try {
      if (updateMap.length > 1) {
        final url = Uri.parse(MyServerConst.ADS_UPDATE);
        final request = await http
            .post(url,
                headers: {
                  'authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                  'language': lang ?? '',
                },
                body: json.encode(updateMap))
            .onError((error, stackTrace) {
          print(stackTrace.toString());
          throw error.toString();
        });
        final responseData = json.decode(request.body);
        if (responseData['success'] == 0) {
          throw responseData['message'];
        } else {
          if (imageMap != null) {
            return await uploadImage(
              id: updateMap['_id'],
              imageBytes: imageMap['image']['imageBytes'],
              fileName: imageMap['image']['fileName'],
              fileMime: imageMap['image']['fileMime'],
            );
          }
        }

        return responseData['message'];
      } else {
        return await uploadImage(
          id: updateMap['_id']!,
          imageBytes: imageMap!['imageBytes'],
          fileName: imageMap['fileName'],
          fileMime: imageMap['fileMime'],
        );
      }
    } catch (error) {
      throw error;
    }
  }

//
  static Future<String> deleteAd({
    required String id,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.ADS_DELETE);
      final request = await http
          .post(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
        },
        body: json.encode(
          {
            '_id': id,
          },
        ),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(request.body);
      if (responseData['success'] == 0) {
        throw responseData['message'];
      }

      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }

//
  static Future<String> uploadImage({
    required String id,
    required String fileName,
    required String fileMime,
    required Uint8List imageBytes,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.ADS_UPLOAD);

      final request = http.MultipartRequest('POST', url);

      request.headers['authorization'] = 'Bearer $token';
      request.headers['_id'] = id;
      request.headers['content-type'] = 'multipart/form-data';
      request.headers['language'] = lang ?? '';

      final mimeList = fileMime.split('/');
      request.files.add(
        http.MultipartFile.fromBytes(
          'banner',
          imageBytes,
          filename: fileName,
          contentType: MediaType(mimeList[0], mimeList[1]),
        ),
      );

      final response = await http.Response.fromStream(await request.send())
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(response.body);

      if (responseData["success"] == 0) {
        throw responseData['message'];
      }

      return responseData['message'];
    } catch (e) {
      throw e;
    }
  }
}
