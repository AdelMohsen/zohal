
import 'package:http/http.dart' as http;
import 'package:zohal/constance/end_point.dart';
import 'dart:convert';

import 'package:zohal/constance/strings.dart';

class MyServerOrders {
   static Future<String> changeShipmentStatus({
    String? lang,
    required Map<String, dynamic> updateMap,
  }) async {
    try {
      final url = Uri.parse(BASE_URL + ORDERS_UPDATE);
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

  static Future<List<dynamic>> getVendorActiveList({String? lang}) async {
    try {
      final url = Uri.parse(BASE_URL+ORDERS_ACTIVE);

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

  static Future<List<dynamic>> getVendorHistoryList({String? lang}) async {
    try {
      final url = Uri.parse(BASE_URL+ORDERS_HISTORY);

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