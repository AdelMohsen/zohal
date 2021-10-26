import 'package:zohal/models/auth_model/login_model.dart';

abstract class AuthStates {}

class InitialAuthState extends AuthStates {}

class ObSecureLoginSuccessState extends AuthStates {}

class ObSecureSignUpSuccessState extends AuthStates {}

class UserLoginLoadingState extends AuthStates {}

class UserLoginSuccessState extends AuthStates {
  UserLogin userLoginModel;
  UserLoginSuccessState(this.userLoginModel);
}

class UserLoginErrorState extends AuthStates {
  UserLogin userLoginModel;
  UserLoginErrorState(this.userLoginModel);
}

class LockOriantaitonLandScapeSuccessState extends AuthStates {}

class GetProfileDataLoadingState extends AuthStates {}

class GetProfileDataSuccessState extends AuthStates {}

class GetProfileDataErrorState extends AuthStates {}

class SignOutAuthLoadingState extends AuthStates {}

class SignOutAuthSuccessState extends AuthStates {}

class SignOutAuthErrorState extends AuthStates {}

class LoginAsVisitorLoadingState extends AuthStates {}

class LoginAsVisitorSuccessState extends AuthStates {
  String tokenId;
  LoginAsVisitorSuccessState(this.tokenId);
}

class LoginAsVisitorErrorState extends AuthStates {}
