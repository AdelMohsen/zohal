import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of(context);

//Login_Screen_Start
  bool obSecureLogin = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();

  changeObSecureLogin() {
    obSecureLogin = !obSecureLogin;
    emit(ObSecureLoginSuccessState());
  }

//Login_Screen_Start

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
}
