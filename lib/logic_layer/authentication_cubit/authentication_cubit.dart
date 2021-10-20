import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/models/auth_model/login_model.dart';
import 'package:zohal/network/dio_helper.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'authentication_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of(context);

//Login_Screen_Start
  UserLogin? userLoginModel;
  bool obSecureLogin = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();

  changeObSecureLogin() {
    obSecureLogin = !obSecureLogin;
    emit(ObSecureLoginSuccessState());
  }

  userLoginFunction({required String userEmail, required String userPassword}) {
    emit(UserLoginLoadingState());
    DioHelper.postLogin(
      url: LOGIN,
      data: {"email": userEmail, "password": userPassword},
      connectTimeOut: 60 * 1000,
      receiveTimeOut: 60 * 1000,
    ).then((value) {
      userLoginModel = UserLogin.fromJson(value.data);
      print(userLoginModel!.success);
      print(userLoginModel!.token!.id);
      print(userLoginModel!.message);
      emit(UserLoginSuccessState(userLoginModel!));
    }).catchError((error) {
      emit(UserLoginErrorState(userLoginModel!));
      print(error.toString());

      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    });
  }

//Login_Screen_End

//Get_User_Profile_Data_Start
  UserData? userData;

  // getProfileData({firstToken}) {
  //   emit(GetProfileDataLoadingState());
  //   DioHelper.getData(
  //     url: PROFILE_INFO,
  //     token:firstToken ?? token,
  //   ).then((value) {
  //     userData = UserData.fromJson(value.data);
  //     print(userData!.userInfo!.email);
  //     print(userData!.userInfo!.id);
  //     print(userData!.userInfo!.firstName);
  //     emit(GetProfileDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     Fluttertoast.showToast(
  //         msg: error.toString(), toastLength: Toast.LENGTH_LONG);
  //     emit(GetProfileDataErrorState());
  //   });
  // }
//Get_User_Profile_Data_END

//Signup_Screen_Start
  bool obSecureSignUp = true;
  var signUpNameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpKey = GlobalKey<FormState>();

  changeObSecureSignUp() {
    obSecureSignUp = !obSecureSignUp;
    emit(ObSecureSignUpSuccessState());
  }

//Signup_Screen_End

//Phone_Screen_Start
  var phoneNumberController = TextEditingController();
  var phoneKey = GlobalKey<FormState>();

//Phone_Screen_End

//Otp_Screen_Start
  var otpController = TextEditingController();
  var otpKey = GlobalKey<FormState>();
//Otp_Screen_End

  lockOriantationLandScape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    emit(LockOriantaitonLandScapeSuccessState());
  }

  Timer? authTimer;
  void autoLogout(context) {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpiry = timeExpire!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(
      Duration(seconds: timeToExpiry),
      () => signOutInAuth(context),
    );
  }

  signOutInAuth(context) {
    emit(SignOutAuthLoadingState());
    CacheHelper.removeData(key: 'token').then((value) {
      CacheHelper.removeData(key: 'timeExpire');
      CacheHelper.removeData(key: 'type');
      userData = null;
      navigateAndRemove(context, const SignupOrLogin());
      emit(SignOutAuthSuccessState());
    }).catchError((error) {
      emit(SignOutAuthErrorState());
    });
  }
}
