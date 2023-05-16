import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/movie_ticket_booking_application.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/branch_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/checkout_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/combo_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/show_time_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/jwt_provider.dart';

void main() async {
  // usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyARE8AOvdVKdvaYECInb1wvMoVnM1Qf_7M",
      authDomain: "movie-ticket-booking-383806.firebaseapp.com",
      projectId: "movie-ticket-booking-383806",
      storageBucket: "movie-ticket-booking-383806.appspot.com",
      messagingSenderId: "915458067606",
      appId: "1:915458067606:web:8e7fc8b87c32abcbaf06b7",
      measurementId: "G-NJNWB7JVLV",
    ),
  );
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "611064467631238",
      cookie: true,
      xfbml: true,
      version: "v16.0",
    );
  }
  AuthenticationService.instance.init();
  bool isLoggedIn = await AuthenticationService.instance.isLoggedIn();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          Provider(create: (_) => ApiProvider(_)),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => SearchingProvider()),
          ChangeNotifierProvider(create: (_) => InformationTicketSelectedProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseStorageProvider()),
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(create: (_) => ShowTimeProvider()),
          ChangeNotifierProvider(create: (_) => BranchProvider()),
          ChangeNotifierProvider(create: (_) => CheckoutProvider()),
          ChangeNotifierProvider(create: (_) => ComboProvider()),
        ],
        child: MovieTicketBookingApplication(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}
