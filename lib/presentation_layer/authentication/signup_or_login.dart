import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/presentation_layer/authentication/login_screen.dart';
import 'package:zohal/presentation_layer/authentication/signup_screen.dart';

class SignupOrLogin extends StatelessWidget {
  const SignupOrLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/zohal.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'ZOHAL',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#072C3F'),
                    ),
                  ),
                  AutoSizeText(
                    'Discover everything about Shopping',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        color: HexColor('#707070')),
                    maxLines: 2,
                    minFontSize: 20,
                    maxFontSize: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    orangeButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      function: () {
                        navigateTo(context, const SignupScreen());
                      },
                    ),
                    whiteButton(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              color: HexColor('#FF6600'),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        function: () {
                          navigateTo(context, const LoginScreen());
                        }),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Skip for now',
                          style: TextStyle(
                              fontSize: 18, color: HexColor('#072C3F')),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
