import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/seat_booking_screen.dart';

enum RouteData {
  home,
  login,
  register,
  notFound,
  movie,
  ticket,
  seat,
  contact,
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  static RouteHandler get instance => _instance;

  final AuthenticationService _authentacationService = AuthenticationService.instance;

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Future<Widget> getRouteWidget(String? routeName) async {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        if (uri.pathSegments.length == 1) {
          final pathName = uri.pathSegments.elementAt(0).toString();
          routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

          if (routeData != RouteData.notFound) {
            bool isLoggedIn = await _authentacationService.isLoggedIn();
            switch (routeData) {
              case RouteData.home:
                return const HomeScreen();
              case RouteData.movie:
                return const MovieScreen();
              case RouteData.ticket:
                return const TicketBookingScreen();
              case RouteData.seat:
                return const SeatBookingScreen();
              // case RouteData.contact:
              //   return const ContactScreen();
              case RouteData.notFound:
                return const FullWidth();
              default:
                return isLoggedIn && routeData == RouteData.login ? const HomeScreen() : const LoginScreen();
            }
          } else {
            return const FullWidth();
          }
        } else if (uri.pathSegments.length == 2) {
          if (uri.pathSegments[0] == "movie") {
            String? slug = uri.pathSegments[1];
            if (slug.isEmpty) return const FullWidth();
            return MovieDetailScreen(slug: slug);
          }
          return const FullWidth();
        } else {
          return const FullWidth();
        }
      } else {
        return const HomeScreen();
      }
    } else {
      return const FullWidth();
    }
  }

  /// Return [RouteTitle]
  /// [RouteTitle] - Return specific title for each route
  String getRouteTitle(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.notFound:
              return 'Not Found';
            case RouteData.login:
              return 'Đăng nhập';
            case RouteData.home:
              return 'Trang chủ';
            case RouteData.movie:
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
