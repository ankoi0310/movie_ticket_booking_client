import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default_layout.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/home_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/movie_detail_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
  // RegisterScreen.routeName: (BuildContext context) => const RegisterScreen(),
  // ProfileScreen.routeName: (BuildContext context) => const ProfileScreen(),
  HomeScreen.routeName: (BuildContext context) =>
      const DefaultLayout(child: HomeScreen()),
  MovieDetailScreen.routeName: (BuildContext context) => MovieDetailScreen(),
};
