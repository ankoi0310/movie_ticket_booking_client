import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/movie_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/firebase_storage_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/loading_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_route_information_parser.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_router_delegate.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/routes.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/register_screen.dart';

import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(context),
      theme: themeData(context),
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

void main() async {
  // usePathUrlStrategy();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyARE8AOvdVKdvaYECInb1wvMoVnM1Qf_7M",
          authDomain: "movie-ticket-booking-383806.firebaseapp.com",
          projectId: "movie-ticket-booking-383806",
          storageBucket: "movie-ticket-booking-383806.appspot.com",
          messagingSenderId: "915458067606",
          appId: "1:915458067606:web:8e7fc8b87c32abcbaf06b7",
          measurementId: "G-NJNWB7JVLV")
  );

  initializeDateFormatting().then(
        (_) => runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SearchingProvider()),
              ChangeNotifierProvider(create: (_) => ScrollingProvider()),
              ChangeNotifierProvider(create: (_) => InformationTicketSelectedProvider()),
              ChangeNotifierProvider(create: (_) => FirebaseStorageProvider()),
              ChangeNotifierProvider(create: (_) => LoadingProvider()),
              ChangeNotifierProvider(create: (_) => MovieProvider())
            ],
            child: const MyApp(),
          ),
        )),
  );

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      darkTheme: darkThemeData(),
      theme: themeData(),
      title: 'Đặt vé xem phim',
      routerDelegate: MovieRouterDelegate(),
      routeInformationParser: MovieRouteInformationParser(),
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(location: '/'),
      ),