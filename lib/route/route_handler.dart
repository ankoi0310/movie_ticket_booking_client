import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/error/not_found_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/seat_booking_screen.dart';

class RouteData {
  final String name;

  // static List<RouteData> values = [];

  const RouteData._(this.name);
}

class PublicRouteData extends RouteData {
  static const home = PublicRouteData._('home');
  static const login = PublicRouteData._('login');
  static const register = PublicRouteData._('register');
  static const movie = PublicRouteData._('movie');
  static const ticket = PublicRouteData._('ticket');
  static const seat = PublicRouteData._('seat');
  static const checkout = PublicRouteData._('checkout');
  static const contact = PublicRouteData._('contact');

  static List<PublicRouteData> values = [
    home,
    login,
    register,
    movie,
    ticket,
    seat,
    checkout,
    contact,
  ];

  const PublicRouteData._(String name) : super._(name);
}

class AuthRouteData extends RouteData {
  static const profile = AuthRouteData._('profile');

  static List<AuthRouteData> values = [
    profile,
  ];

  const AuthRouteData._(String name) : super._(name);
}

class ErrorRouteData extends RouteData {
  static const notFound = ErrorRouteData._('not-found');
  static const internalServerError = ErrorRouteData._('internal-server-error');

  static List<ErrorRouteData> values = [
    notFound,
    internalServerError,
  ];

  const ErrorRouteData._(String name) : super._(name);
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  static RouteHandler get instance => _instance;

  final AuthenticationService _authentacationService =
      AuthenticationService.instance;

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Future<Widget> getRouteWidget(String? routeName) async {
    if (routeName == null) return const NotFoundScreen();

    final uri = Uri.parse(routeName);

    if (uri.pathSegments.isEmpty) return const HomeScreen();

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();

      List<RouteData> values = [
        ...PublicRouteData.values,
        ...ErrorRouteData.values
      ];

      bool isLoggedIn = await _authentacationService.isLoggedIn();
      if (isLoggedIn) {
        values.addAll(AuthRouteData.values);
      }

      final routeData = values.firstWhere((element) => element.name == pathName,
          orElse: () => ErrorRouteData.notFound);

      if (routeData != ErrorRouteData.notFound) {
        if (isLoggedIn) {
          switch (routeData) {
            case AuthRouteData.profile:
              return const HomeScreen();
          }
        }

        switch (routeData) {
          case PublicRouteData.movie:
            return const MovieScreen();
          case PublicRouteData.ticket:
            return const TicketBookingScreen();
          case PublicRouteData.seat:
            return const SeatBookingScreen();
          // case RouteData.contact:
          //   return const ContactScreen();
          case PublicRouteData.login:
            return isLoggedIn ? const HomeScreen() : const LoginScreen();
          case PublicRouteData.register:
            return const RegisterScreen();
          case PublicRouteData.home:
          default:
            return const HomeScreen();
        }
      } else {
        return const NotFoundScreen();
      }
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == "movie") {
        String? slug = uri.pathSegments[1];
        if (slug.isEmpty) return const NotFoundScreen();
        return MovieDetailScreen(slug: slug);
      }
      return const NotFoundScreen();
    }

    return const NotFoundScreen();
  }

  /// Return [RouteTitle]
  /// [RouteTitle] - Return specific title for each route
  Future<String> getRouteTitle(String? routeName) async {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        bool isLoggedIn = await _authentacationService.isLoggedIn();
        final values = isLoggedIn
            ? [...PublicRouteData.values, ...AuthRouteData.values]
            : PublicRouteData.values;
        routeData = values.firstWhere((element) => element.name == pathName,
            orElse: () => ErrorRouteData.notFound);

        if (routeData != ErrorRouteData.notFound) {
          switch (routeData) {
            case ErrorRouteData.notFound:
              return 'Not Found';
            case ErrorRouteData.internalServerError:
              return 'Internal Server Error';
            case PublicRouteData.login:
              return 'Đăng nhập';
            case PublicRouteData.home:
              return 'Trang chủ';
            case PublicRouteData.movie:
              return 'Phim';
            default:
              return 'Trang chủ';
          }
        } else {
          return 'Not Found';
        }
      } else {
        return 'Dashboard';
      }
    } else {
      return 'Not Found';
    }
  }
}
