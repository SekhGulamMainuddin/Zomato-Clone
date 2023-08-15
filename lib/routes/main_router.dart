import 'package:flutter/material.dart';
import 'package:zomato_clone/features/loginandsignup/screens/login_screen.dart';
import 'package:zomato_clone/features/loginandsignup/screens/verify_otp_screen.dart';
import 'package:zomato_clone/features/main_home/profile/screens/activity_screen.dart';
import 'package:zomato_clone/features/main_home/screens/main_home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  dynamic page;
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      page = const LoginScreen();
      break;
    case MainHomeScreen.routeName:
      page = const MainHomeScreen();
      break;
    case ActivityScreen.routeName:
      page = const ActivityScreen();
      break;
    case VerifyOTPScreen.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final verificationId = arguments["verificationId"] as String;
      final resendToken = arguments["resendToken"] as int?;
      final phoneNumber = arguments["phoneNumber"] as String;
      page = VerifyOTPScreen(verificationId, resendToken, phoneNumber);
      break;
    default:
      page = const Scaffold(
        body: Center(
          child: Text(
            "Page Doesn't Exists",
            style: TextStyle(fontSize: 26),
          ),
        ),
      );
  }
  return MaterialPageRoute<dynamic>(builder: (context) => page);
}
