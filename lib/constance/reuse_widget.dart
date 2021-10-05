import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

orangeButton({required void Function() function, required Widget child}) =>
    ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 44.0),
      child: MaterialButton(
        minWidth: double.infinity - 50,
        height: 44,
        color: HexColor('#FF6600'),
        onPressed: function,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );

whiteButton({
  void Function()? function,
  required Widget child,
}) =>
    ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 44.0),
      child: MaterialButton(
        minWidth: double.infinity - 50,
        height: 44,
        color: Colors.white,
        onPressed: function,
        child: child,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: HexColor('#FF6600'), width: 1.5)),
      ),
    );

defaultTextFormField({
  required String hintText,
  required TextInputType keyboardType,
  InputBorder? border,
  required TextEditingController controller,
}) =>
    TextFormField(
      validator: (value) => value!.isEmpty ? 'This field is required' : null,
      controller: controller,
      decoration: InputDecoration(
        fillColor: HexColor('#F3F3F3'),
        filled: true,
        hintText: hintText,
        border: border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
      ),
      keyboardType: keyboardType,
    );

passwordTextFormField(
        {required String hintText,
        required Widget suffixIcon,
        required TextEditingController controller,
        required bool obscureText,
        required TextInputType keyboardType}) =>
    TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) => value!.isEmpty ? 'This field is required' : 'null',
      decoration: InputDecoration(
          fillColor: HexColor('#F3F3F3'),
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
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
