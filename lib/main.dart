import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/scrolling_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_route_information_parser.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_router_delegate.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchingProvider()),
        ChangeNotifierProvider(create: (_) => ScrollingProvider()),
        ChangeNotifierProvider(create: (_) => InformationTicketSelectedProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(),
      theme: themeData(),
      title: 'Đặt vé xem phim',
      routerDelegate: MovieRouterDelegate(),
      routeInformationParser: MovieRouteInformationParser(),
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(location: '/'),
      ),
    );
  }
}
