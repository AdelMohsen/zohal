import 'package:flutter/material.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/onboarding_screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.readData(key: 'onBoarding') ?? false;
  Widget widget;
  if (onBoarding == false) {
    widget = const OnboardingScreen();
  } else {
    widget = const SignupOrLogin();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: startWidget,
    );
  }
}
