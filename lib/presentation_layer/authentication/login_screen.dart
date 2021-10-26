import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_state.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/presentation_layer/authentication/signup_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';
import 'package:zohal/presentation_layer/vendor/vendor_home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..lockOriantationLandScape(),
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is UserLoginErrorState) {
          Fluttertoast.showToast(
              msg: state.userLoginModel.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (state is UserLoginSuccessState) {
          //UserData? userData;
          // AuthCubit.get(context).userData!.userInfo!.firstName =
          //     state.userLoginModel.userDataFromLogin!.firstName;
          // AuthCubit.get(context).userData!.userInfo!.address =
          //     state.userLoginModel.userDataFromLogin!.address1;
          // AuthCubit.get(context).userData!.userInfo!.photoUrl =
          //     state.userLoginModel.userDataFromLogin!.photoUrl;
          print(state.userLoginModel.userDataFromLogin!.firstName);
          // print(state.userLoginModel.userDataFromLogin!.address1);
          // print(state.userLoginModel.userDataFromLogin!.photoUrl);
          // print(state.userLoginModel.userDataFromLogin!.email);
          // print(state.userLoginModel.userDataFromLogin!.language);
          // print(state.userLoginModel.userDataFromLogin!.phone1);
          // print(state.userLoginModel.userDataFromLogin!.type);
          // AuthCubit.get(context).userData!.userInfo!.firstName =
          //     state.userLoginModel.userDataFromLogin!.firstName;
          // UserInfo.name(
          //   firstName: state.userLoginModel.userDataFromLogin!.firstName,
          //   lastName: state.userLoginModel.userDataFromLogin!.lastName,
          //   address: state.userLoginModel.userDataFromLogin!.address1,
          //   address2: state.userLoginModel.userDataFromLogin!.address2,
          //   email: state.userLoginModel.userDataFromLogin!.email,
          //   photoUrl: state.userLoginModel.userDataFromLogin!.photoUrl,
          // );
          // userData!.userInfo!.firstName =
          //     state.userLoginModel.userDataFromLogin!.firstName;
          // print(userData.userInfo!.firstName);
          //print(AuthCubit.get(context).userData!.userInfo!.phone1);
          CacheHelper.saveData(
              key: 'userId',
              value: state.userLoginModel.userDataFromLogin!.userId);
          CacheHelper.saveData(
                  key: 'token', value: state.userLoginModel.token!.id)
              .then((value) {
            token = state.userLoginModel.token!.id;
            print('token saved');
          });
          final dateExpire = DateTime.now().add(Duration(
            seconds: state.userLoginModel.token!.expiresInSeconds!.toInt(),
          ));
          CacheHelper.saveData(
                  key: 'timeExpire', value: dateExpire.toIso8601String())
              .then((value) {
            timeExpire = dateExpire;
            print('timeExpire Saved');
          });
          CacheHelper.saveData(
                  key: 'type',
                  value: state.userLoginModel.userDataFromLogin!.type)
              .then((value) {
            type = state.userLoginModel.userDataFromLogin!.type;
            print('type was saved');
          });
          if (state.userLoginModel.userDataFromLogin!.type == 3) {
            navigateAndRemove(
              context,
              HomeLayout(),
            );
          } else {
            navigateAndRemove(
              context,
              const VendorHomeScreen(),
            );
          }

          //TODO : كمل باقي الموديل من الموديل اللوجين وتاني مره يحمل الداتا
        }
      }, builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.loginKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 100.0,
                      child: Image.asset('assets/images/zohal.png')),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: defaultTextFormField(
                        contentPadding:
                            const EdgeInsetsDirectional.only(start: 10.0),
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
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.deepOrange,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.deepOrange,
                              ),
                      ),
                    ),
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        state is! UserLoginLoadingState ||
                        state is UserLoginErrorState,
                    widgetBuilder: (context) => Padding(
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
                            cubit.userLoginFunction(
                                userEmail: cubit.emailController.text,
                                userPassword: cubit.passwordController.text);
                          }
                        },
                      ),
                    ),
                    fallbackBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.deepOrange,
                        ),
                      ),
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
                            child: Image.asset('assets/images/facebook.png'),
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
                                    width: 1.29, color: HexColor('#707070'))),
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
                                    width: 1.29, color: HexColor('#707070'))),
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
