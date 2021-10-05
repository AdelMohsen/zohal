import 'package:flutter/material.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildVisaPaymentMethod() => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SizedBox(
            height: 35.0,
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 5.0, left: 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'Name on Card',
                  hintStyle: const TextStyle(fontSize: 12)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: SizedBox(
            height: 35.0,
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 5.0, left: 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'Card Number',
                  hintStyle: const TextStyle(fontSize: 12)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SizedBox(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Center(
                      child: Text(
                        'CVV',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: orangeButton(
              function: () {},
              child: const Text(
                'CHECKOUT',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )),
        )
      ],
    );
