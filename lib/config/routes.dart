import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/change_password/change_password_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/login/login_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/profile_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/register_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
  RegisterScreen.routeName: (BuildContext context) => const RegisterScreen(),
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
  ProfileScreen.routeName: (BuildContext context) => const ProfileScreen(),
  ChangePasswordScreen.routeName: (BuildContext context) => const ChangePasswordScreen(),
};
