import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_state.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';

class PhoneAuthenticationScreen extends StatelessWidget {
  const PhoneAuthenticationScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.all(40.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 100.0,
                        child: Image.asset('assets/images/zohal.png')),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          'Welcome! to ZOHAL',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'To Create Account Please Enter Your Phone',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#707070'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        height: 50.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50.0,
                                child: const Center(
                                  child: Text(
                                    '+20',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: HexColor('#FA8638'),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: defaultTextFormField(
                                  controller: cubit.phoneNumberController,
                                  hintText: 'Your Phone',
                                  keyboardType: TextInputType.number),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: orangeButton(
                          function: () {
                            if (cubit.phoneKey.currentState!.validate()) {
                              navigateTo(context, const HomeScreen());
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
