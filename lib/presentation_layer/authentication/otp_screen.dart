import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_state.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: cubit.otpKey,
                child: ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    Center(
                      child: Text(
                        'Verification',
                        style: TextStyle(
                          color: HexColor('#072C3F'),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'A 6 - Digit PIN has been sent to your email address, enter it below to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: HexColor('#707070'),
                            height: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PinCodeTextField(
                        controller: cubit.otpController,
                        keyboardType: TextInputType.number,
                        cursorHeight: 35,
                        cursorColor: Colors.black,
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.scale,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 44,
                            fieldWidth: 44,
                            activeFillColor: HexColor('#FF6600'),
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.grey,
                            inactiveFillColor: Colors.white,
                            borderWidth: 1.29),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onChanged: (String value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: orangeButton(
                          function: () {
                            if (cubit.otpKey.currentState!.validate()) {
                              // ignore: avoid_print
                              print('done');
                            }
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Send Code Again ?',
                          style: TextStyle(
                            color: HexColor('#707070'),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
