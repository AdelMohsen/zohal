import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/auth_provider/auth.dart';
import 'package:zohal/constance/ob_server.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/network/dio_helper.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';
import 'package:zohal/presentation_layer/onboarding_screens/onboarding_screen.dart';
import 'package:zohal/presentation_layer/vendor/vendor_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onBoarding = CacheHelper.readData(key: 'onBoarding') ?? false;
  token = CacheHelper.readData(key: 'token') ?? '';
  type = CacheHelper.readData(key: 'type') ?? 0;
  final runTimeExpire = CacheHelper.readData(key: 'timeExpire') ?? '';
  userId = CacheHelper.readData(key: 'userId') ?? '';
  bool? autoLoginChange;
  Widget widget;

  if (onBoarding == true) {
    if (token == '') {
      widget = const SignupOrLogin();
      autoLoginChange = false;
    } else {
      if (runTimeExpire != '') {
        timeExpire = DateTime.parse(runTimeExpire as String);
        autoLoginChange = true;
        if (type == 3) {
          widget = HomeLayout();
        } else if (type == 2) {
          widget = const VendorHomeScreen();
        } else {
          widget = const SignupOrLogin();
          autoLoginChange = false;
        }
      } else {
        widget = const OnboardingScreen();
        autoLoginChange = false;
      }
    }
  } else {
    widget = const OnboardingScreen();
  }

  // if (token == '') {
  //   widget = const SignupOrLogin();
  // } else {
  //   if (runTimeExpire != '') {
  //     timeExpire = DateTime.parse(runTimeExpire as String);
  //     autoLoginChange = true;
  //     if (onBoarding == true) {
  //       if (type == 3) {
  //         widget = const HomeLayout();
  //       } else if (type == 2) {
  //         widget = const VendorHomeScreen();
  //       } else {
  //         widget = const SignupOrLogin();
  //       }
  //     } else {
  //       widget = const OnboardingScreen();
  //     }
  //   } else {
  //     widget = const SignupOrLogin();
  //     autoLoginChange = true;
  //   }
  // }

  runApp(EasyLocalization(
    child: MyApp(widget, autoLoginChange ?? false),
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translation',
    saveLocale: true,
    fallbackLocale: const Locale('en'),
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? autoLoginChange;

  const MyApp(this.startWidget, this.autoLoginChange, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: autoLoginChange == true
          ? [
              BlocProvider(
                create: (context) => HomeCubit(),
              ),
              BlocProvider(
                create: (context) => AuthCubit()..autoLogout(context),
              )
            ]
          : [
              BlocProvider(create: (context) => AuthCubit()),
              BlocProvider(
                create: (context) => HomeCubit(),
              ),
            ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: startWidget,
      ),
    );
  }
}
