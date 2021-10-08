import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/ob_server.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/onboarding_screens/onboarding_screen.dart';
import 'package:zohal/presentation_layer/vendor/vendor_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
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
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeCubit(),),],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: VendorHomeScreen(),
        //startWidget,
      ),
    );
  }
}
