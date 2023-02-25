import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/profile_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/register_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
  RegisterScreen.routeName: (BuildContext context) => const RegisterScreen(),
  ProfileScreen.routeName: (BuildContext context) => const ProfileScreen(),
};
