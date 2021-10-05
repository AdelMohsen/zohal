import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';

class ConfirmedPage extends StatelessWidget {
  const ConfirmedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: HexColor('#FF6600'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/checkout/confirmed.png',
            width: 130.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Thank You!',
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const Text(
            'Your order is confirmed.',
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 44,
            child: whiteButton(
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: HexColor('#FF6600'),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                function: () {}),
          )
        ],
      ),
    );
  }
}
