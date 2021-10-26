import 'package:http/http.dart' as http;
import 'package:zohal/constance/strings.dart';
import 'dart:convert';

import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class MyServerSubSections {
  static Future<List<dynamic>> getListNoCategory() async {
    try {
      final url = Uri.parse(MyServerConst.SUB_SECTIONS_LIST + '?cat=-1');

      final request = await http.post(
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
}
