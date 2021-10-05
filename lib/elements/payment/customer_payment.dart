import 'package:flutter/material.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildCustomerPaymentMethod() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
  child: orangeButton(
      function: () {},
      child: const Text(
        'CHECKOUT',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15),
      )),
);