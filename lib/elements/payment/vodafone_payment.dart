import 'package:flutter/material.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildVodafonePaymentMethod() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          SizedBox(
            height: 35.0,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          '+20',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 1,
                            color: Colors.grey,
                            height: 33,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.only(top: 5.0, left: 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'Your Phone',
                  hintStyle: const TextStyle(fontSize: 12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
      ),
    );
