import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:zohal/constance/strings.dart';
import 'dart:convert';

import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class MyServerProducts {
  static Future<List<dynamic>> getList() async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_LIST);

      final request = await http.get(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
        },
      ).onError((error, stackTrace) {
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

  static Future<List<dynamic>> getSizes({
    required String productId,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_SIZES);

      final request = await http.get(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
          '_id': productId,
        },
      ).onError((error, stackTrace) {
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

  static Future<List<dynamic>> getDecorations(
    String _id,
  ) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_DECO);

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
            '_id': _id,
          },
        ),
      )
          .onError((error, stackTrace) {
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

  static Future<String> addDecor({
    required String id,
    required String color,
    required Uint8List? imageBytes1,
    required String fileName1,
    required String fileMime1,
    required Uint8List? imageBytes2,
    required String fileName2,
    required String fileMime2,
    required Uint8List? imageBytes3,
    required String fileName3,
    required String fileMime3,
    required Uint8List? imageBytes4,
    required String fileName4,
    required String fileMime4,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_DECO_ADD);

      final request = http.MultipartRequest('POST', url);

      request.headers['authorization'] = 'Bearer $token';
      request.headers['_id'] = id;
      request.headers['content-type'] = 'multipart/form-data';
      request.headers['language'] = lang ?? '';

      request.fields['color'] = color;

      final mimeList = fileMime1.split('/');
      request.files.add(
        http.MultipartFile.fromBytes(
          'image1',
          imageBytes1!,
          filename: fileName1,
          contentType: MediaType(mimeList[0], mimeList[1]),
        ),
      );

      if (imageBytes2 != null) {
        final mimeList = fileMime2.split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image2',
            imageBytes2,
            filename: fileName2,
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

      if (imageBytes3 != null) {
        final mimeList = fileMime3.split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image3',
            imageBytes3,
            filename: fileName3,
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

      if (imageBytes4 != null) {
        final mimeList = fileMime4.split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image4',
            imageBytes4,
            filename: fileName4,
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

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

  static Future<String> updateDecor({
    required Map<String, dynamic> updateMap,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_DECO_UPDATE);
      final request = http.MultipartRequest('POST', url);

      request.headers['authorization'] = 'Bearer $token';
      request.headers['_id'] = updateMap['_id'];
      request.headers['content-type'] = 'multipart/form-data';
      request.headers['language'] = lang ?? '';

      request.fields['decorId'] = updateMap['decorId'];

      if (updateMap['color'] != null) {
        request.fields['color'] = updateMap['color'];
      }

      if (updateMap['image1'] != null) {
        final mimeList = updateMap['image1']['fileMime1'].split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image1',
            updateMap['image1']['imageBytes1'],
            filename: updateMap['image1']['fileName1'],
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

      if (updateMap['image2'] != null) {
        final mimeList = updateMap['image2']['fileMime2'].split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image2',
            updateMap['image2']['imageBytes2'],
            filename: updateMap['image2']['fileName2'],
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

      if (updateMap['image3'] != null) {
        final mimeList = updateMap['image3']['fileMime3'].split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image3',
            updateMap['image3']['imageBytes3'],
            filename: updateMap['image3']['fileName3'],
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

      if (updateMap['image4'] != null) {
        final mimeList = updateMap['image4']['fileMime4'].split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image4',
            updateMap['image4']['imageBytes4'],
            filename: updateMap['image4']['fileName4'],
            contentType: MediaType(mimeList[0], mimeList[1]),
          ),
        );
      }

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
    } catch (error) {
      throw error;
    }
  }

  static Future<String> deleteDecor({
    required String productId,
    required String decorId,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_DECO_DELETE);
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
            'productId': productId,
            'decorId': decorId,
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

  static Future<String> addProduct({
    required String name,
    required String arabicName,
    required String model,
    required String price,
    required String description,
    required String inStock,
    required String hasSizes,
    required String brandId,
    required String categoryId,
    required String sectionId,
    required String subSectionId,
    required String vendorId,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_ADD);
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
            'name': name,
            'arabicName': arabicName,
            'model': model,
            'price': price,
            'description': description,
            'inStock': inStock,
            'hasSizes': hasSizes,
            'brandId': brandId,
            'categoryId': categoryId,
            'sectionId': sectionId,
            'subSectionId': subSectionId,
            'vendorId': vendorId,
          },
        ),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(request.body);

      if (responseData['success'] == 0) throw responseData['message'];

      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<String> updateProduct({
    required Map<String, dynamic> updateMap,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_UPDATE);
      final request = await http
          .post(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
        },
        body: json.encode(updateMap),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(request.body);
      if (responseData['success'] == 0) throw responseData['message'];

      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<String> deleteProduct({
    required String id,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_DELETE);
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

  static Future<String> addSize({
    required String id,
    required String name,
  }) async {
    try {
      final url = Uri.parse(
        MyServerConst.PRODUCTS_SIZE_ADD,
      );
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
            'productId': id,
            'name': name,
          },
        ),
      )
          .onError((error, stackTrace) {
        print(stackTrace.toString());
        throw error.toString();
      });

      final responseData = json.decode(request.body);

      if (responseData['success'] == 0) throw responseData['message'];

      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<String> updateSize({
    required Map<String, dynamic> updateMap,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_SIZE_UPDATE);
      final request = await http
          .post(
        url,
        headers: {
          'authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'language': lang ?? '',
        },
        body: json.encode(
          updateMap,
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

  static Future<String> deleteSize({
    required int index,
    required String id,
  }) async {
    try {
      final url = Uri.parse(MyServerConst.PRODUCTS_SIZE_DELETE);
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
            'index': index,
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
}
