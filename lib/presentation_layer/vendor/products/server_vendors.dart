import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class MyServerVendors {
  static Future<List<dynamic>> getProductsList({
    String vendorId = '',
  }) async {
    try {
      final url = Uri.parse(MyServerConst.VENDORS_PRODUCTS);

      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'language': lang ?? '',
      };

      if (vendorId != '') {
        headers['_id'] = vendorId;
      }

      final request = await http
          .get(
        url,
        headers: headers,
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

  static Future<Map<String, dynamic>> getReferrals() async {
    try {
      final url = Uri.parse(MyServerConst.VENDORS_REFERRALS);

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
}
