import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/firebase_options.dart';
import 'package:movie_ticket_booking_flutter_nlu/movie_ticket_booking_application.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/branch_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/checkout_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/combo_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/show_time_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "611064467631238",
      cookie: true,
      xfbml: true,
      version: "v15.0",
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
          ChangeNotifierProvider(create: (_) => AuthenticationService()),
          ChangeNotifierProvider(create: (_) => SearchingProvider()),
          ChangeNotifierProvider(create: (_) => InformationTicketSelectedProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseStorageProvider()),
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(create: (_) => ShowTimeProvider()),
          ChangeNotifierProvider(create: (_) => BranchProvider()),
          ChangeNotifierProvider(create: (_) => CheckoutProvider()),
          ChangeNotifierProvider(create: (_) => ComboProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => NoticeProvider()),
        ],
        child: MovieTicketBookingApplication(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}
