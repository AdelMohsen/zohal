import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_state.dart';
import 'package:zohal/presentation_layer/authentication/signup_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: cubit.loginKey,
                  child: ListView(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 100.0,
                          child: Image.asset('assets/images/zohal.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: defaultTextFormField(
                            controller: cubit.emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: passwordTextFormField(
                          obscureText: cubit.obSecureLogin,
                          keyboardType: TextInputType.visiblePassword,
                          controller: cubit.passwordController,
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeObSecureLogin();
                            },
                            icon: cubit.obSecureLogin
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: orangeButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          function: () {
                            if (cubit.loginKey.currentState!.validate()) {
                              navigateTo(context, const HomeScreen());
                            }
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                                fontSize: 13,
                                color: HexColor('#072C3F'),
                                fontWeight: FontWeight.w600),
                          )),
                      Row(
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
                      const SizedBox(
                        height: 10.0,
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
                        height: 10.0,
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
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: HexColor('#072C3F'),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const SignupScreen());
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: HexColor('#FF6600'),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
