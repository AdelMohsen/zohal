import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

orangeButton(
        {required void Function() function,
        required Widget child,
        double? height,
        double? minWidth,
        ShapeBorder? shape,
        }) =>
    MaterialButton(
      minWidth: minWidth ?? double.infinity - 50,
      height: height ?? 44,
      color: HexColor('#FF6600'),
      onPressed: function,
      child: child,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );

whiteButton({
  void Function()? function,
  required Widget child,
}) =>
    MaterialButton(
      minWidth: double.infinity - 50,
      height: 44,
      color: Colors.white,
      onPressed: function,
      child: child,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: HexColor('#FF6600'), width: 1.5)),
    );

defaultTextFormField(
        {String? hintText,
        TextStyle? hintStyle,
        required TextInputType keyboardType,
        InputBorder? border,
        TextEditingController? controller,
        EdgeInsetsGeometry? contentPadding,
        Widget? prefixIcon,
        bool? enabled,
        String? labelText,
        Function()? onEditingComplete,
        Function(String)? onFieldSubmitted}) =>
    TextFormField(onFieldSubmitted:onFieldSubmitted ,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      validator: (value) => value!.isEmpty ? 'This field is required' : null,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.zero,
        fillColor: HexColor('#F3F3F3'),
        filled: true,
        hintText: hintText ?? '',
        labelText: labelText ?? '',
        hintStyle :hintStyle ,
        border: border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
    );

passwordTextFormField(
        {required String hintText,
        Widget? suffixIcon,
        TextEditingController? controller,
        bool? obscureText,
        required TextInputType keyboardType,
        Color? fillColor,
        BorderSide? borderSide,
        BorderSide? focusBorderSide,
        String? Function(String?)? validator}) =>
    TextFormField(
      obscureText: obscureText ?? true,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator ??
          (value) => value!.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: focusBorderSide ?? BorderSide.none,
          ),
          fillColor: fillColor ?? HexColor('#F3F3F3'),
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: borderSide ?? BorderSide.none,
          ),
          suffixIcon: suffixIcon),
    );

drawerText({
  required String text,
}) =>
    Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: HexColor('#616161'),
      ),
    );

drawerIcon() => Icon(
      Icons.keyboard_arrow_right,
      color: HexColor('#C0C0C0'),
      size: 30,
    );

navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

navigateAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

navigateAndReplace(context,widget)=>  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>widget));


extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

String formatDate(String dateToFormat, bool isEnglish) => DateFormat(
        isEnglish ? 'dd/MM/yyyy' : 'yyyy/MM/dd',
      ).format(DateTime.parse(dateToFormat));