import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/routes.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/home_screen.dart';

import 'config/theme.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(),
      theme: themeData(),
      title: 'Đặt vé xem phim',
      routes: routes,
      initialRoute: HomeScreen.routeName,
    );
  }
}



