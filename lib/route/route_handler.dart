import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/payment_momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/error/unauthorized_screen.dart';

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  static RouteHandler get instance => _instance;

  final AuthenticationService _authentacationService = AuthenticationService.instance;

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Future<Widget> getRouteWidget(String? routeName, {String? jsonObject, Map<String, String>? queryParameters}) async {
    if (routeName == null) return const HomeScreen();

    final uri = Uri.parse(routeName);

    if (uri.pathSegments.isEmpty) return const HomeScreen();

    // No path parameters
    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();

      RouteData.values.addAll(PublicRouteData.values);

      bool isLoggedIn = await _authentacationService.isLoggedIn();
      if (isLoggedIn) {
        RouteData.values.addAll(AuthRouteData.values);
      }

      final routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

      if (routeData != RouteData.notFound) {
        if (!isLoggedIn) {
          switch (routeData) {
            case AuthRouteData.profile:
              return const HomeScreen();
          }
        }

        switch (routeData) {
          case PublicRouteData.movie:
            return const MovieScreen();
          case PublicRouteData.ticket:
            return const TicketBookingScreen(slug: null);
          case PublicRouteData.seat:
            return SeatBookingScreen(jsonObject: jsonObject);
          case PublicRouteData.checkout:
            return CheckoutScreen(jsonObject: jsonObject);
          // case RouteData.contact:
          //   return const ContactScreen();
          case PublicRouteData.login:
            return isLoggedIn ? const HomeScreen() : const LoginScreen();
          case PublicRouteData.register:
            return const RegisterScreen();
          case AuthRouteData.profile:
            return const ProfileScreen();
          case PublicRouteData.home:
          default:
            return const HomeScreen();
        }
      }

      if (AuthRouteData.values.any((element) => element.name == pathName) && !isLoggedIn) {
        return const UnauthorizedScreen();
      }

      return const NotFoundScreen();
    }

    // Has path parameters
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == "movie") {
        String? slug = uri.pathSegments[1];
        if (slug.isEmpty) return const NotFoundScreen();
        return MovieDetailScreen(slug: slug);
      }
      if (uri.pathSegments[0] == "payment" && uri.pathSegments[1] == "return") {
        return PaymentResponseScreen(paymentResponse: PaymentMomoResponse.fromJson(queryParameters!));
      }
      if (uri.pathSegments[0] == "ticket") {
        String? slug = uri.pathSegments[1];
        if (slug.isEmpty) return const NotFoundScreen();
        return TicketBookingScreen(slug: slug);
      }
      return const NotFoundScreen();
    }

    return const NotFoundScreen();
  }

  /// Return [RouteTitle]
  /// [RouteTitle] - Return specific title for each route
  Future<String> getRouteTitle(String? routeName) async {
    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        final routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.notFound:
              return 'Starlinex - Không tìm thấy trang';
            case RouteData.internalServerError:
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
