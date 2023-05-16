import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class MovieTicketBookingApplication extends StatelessWidget {
  final bool isLoggedIn;

  const MovieTicketBookingApplication({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Starlinex - Đặt vé xem phim',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      routerDelegate: AppRouterDelegate(isLoggedIn: isLoggedIn),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}
