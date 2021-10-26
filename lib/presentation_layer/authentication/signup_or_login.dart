import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/presentation_layer/authentication/login_screen.dart';
import 'package:zohal/presentation_layer/authentication/signup_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';

class SignupOrLogin extends StatefulWidget {
  const SignupOrLogin({Key? key}) : super(key: key);

  @override
  State<SignupOrLogin> createState() => _SignupOrLoginState();
}

class _SignupOrLoginState extends State<SignupOrLogin> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SafeArea(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .6),
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
                        onPressed: () {
                         HomeCubit.get(context).loginAsVisitor(context);
                        },
                        child: Text(
                          'Skip for now',
                          style: TextStyle(
                              fontSize: 18, color: HexColor('#072C3F')),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
