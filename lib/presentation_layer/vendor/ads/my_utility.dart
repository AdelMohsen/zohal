import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyUtil {
  static String? isEmailValid(String value, String language) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value) ||
        value.isEmpty) {
      return language == 'EN' || language == ''
          ? 'Please enter a valid email'
          : 'ادخل بريد الكتروني صحيح';
    } else
      return null;
  }

  static String? isPasswordValid(String value, String language) {
    if (value.isEmpty)
      return language == 'EN' || language == ''
          ? 'Please enter a valid password'
          : 'ادخل كلمة مرور صحيحة';
    if (value.length < 6)
      return language == 'EN' || language == ''
          ? 'Password must be more than 6 characters'
          : 'كلمة المرور لا تقل عن 6 رموز';
    return null;
  }

  static void showSnackBar(
      {required BuildContext context, required String msg, int seconds = 4}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  static String formatDate(String dateToFormat, bool isEnglish) => DateFormat(
        isEnglish ? 'dd/MM/yyyy' : 'yyyy/MM/dd',
      ).format(DateTime.parse(dateToFormat));

  static String toRefreshImages() =>
      DateTime.now().millisecondsSinceEpoch.toString();

  static String getAdPosition(String position, bool isEnglish) {
    switch (position) {
      case '0':
        return isEnglish ? 'Top' : 'الأعلي';

      case '1':
        return isEnglish ? 'Middle' : 'الوسط';

      case '2':
        return isEnglish ? 'Bottom' : 'الأسفل';

      default:
        return '';
    }
  }
}
