import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_state.dart';
import 'package:zohal/presentation_layer/authentication/login_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: cubit.signUpKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          height: 100.0,
                          child: Image.asset('assets/images/zohal.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: defaultTextFormField(
                            controller: cubit.signUpNameController,
                            hintText: 'Name',
                            keyboardType: TextInputType.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: defaultTextFormField(
                            controller: cubit.signUpEmailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: passwordTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.obSecureSignUp,
                          controller: cubit.signUpPasswordController,
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeObSecureSignUp();
                            },
                            icon: cubit.obSecureSignUp
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: orangeButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          function: () {
                            if (cubit.signUpKey.currentState!.validate()) {
                              navigateTo(context, const HomeScreen());
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: HexColor('#707070'),
                              thickness: 1.29,
                            )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('or'),
                            ),
                            Expanded(
                                child: Divider(
                              color: HexColor('#707070'),
                              thickness: 1.29,
                            )),
                          ],
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 44,
                        onPressed: () {},
                        minWidth: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                child:
                                    Image.asset('assets/images/facebook.png'),
                                decoration: BoxDecoration(
                                  color: HexColor('#072C3F'),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 44,
                                child: const Center(
                                  child: Text(
                                    'Sign up with Facebook',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: HexColor('#083B55'),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 44,
                        onPressed: () {},
                        minWidth: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                child: Image.asset(
                                  'assets/images/google.png',
                                ),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0),
                                    ),
                                    border: Border.all(
                                        width: 1.29,
                                        color: HexColor('#707070'))),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 44,
                                child: Center(
                                  child: Text(
                                    'Sign up with Facebook',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: HexColor('#707070'),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                    border: Border.all(
                                        width: 1.29,
                                        color: HexColor('#707070'))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Already have an account?',
                              style: TextStyle(
                                color: HexColor('#072C3F'),
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 12,
                              maxFontSize: 17,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const LoginScreen());
                                },
                                child: AutoSizeText(
                                  'Log in',
                                  style: TextStyle(
                                    color: HexColor('#FF6600'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 12,
                                  maxFontSize: 17,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
