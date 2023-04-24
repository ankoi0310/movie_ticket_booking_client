import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/movie_ticket_booking_application.dart';

void main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyARE8AOvdVKdvaYECInb1wvMoVnM1Qf_7M",
          authDomain: "movie-ticket-booking-383806.firebaseapp.com",
          projectId: "movie-ticket-booking-383806",
          storageBucket: "movie-ticket-booking-383806.appspot.com",
          messagingSenderId: "915458067606",
          appId: "1:915458067606:web:8e7fc8b87c32abcbaf06b7",
          measurementId: "G-NJNWB7JVLV"));
  AuthenticationService.instance.init();
  bool isLoggedIn = await AuthenticationService.instance.isLoggedIn();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiProvider(_)),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => SearchingProvider()),
          ChangeNotifierProvider(create: (_) => ScrollingProvider()),
          ChangeNotifierProvider(create: (_) => InformationTicketSelectedProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseStorageProvider()),
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider())
        ],
        child: MovieTicketBookingApplication(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}
