import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/full_width.dart';

enum RouteData {
  home,
  login,
  // register,
  notFound,
  movie,
  booking,
  contact,
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Widget getRouteWidget(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        if (uri.pathSegments.length == 1) {
          final pathName = uri.pathSegments.elementAt(0).toString();
          routeData = RouteData.values.firstWhere(
              (element) => element.name == pathName,
              orElse: () => RouteData.notFound);

          if (routeData != RouteData.notFound) {
            switch (routeData) {
              case RouteData.home:
                return const HomeScreen();
              case RouteData.movie:
                return const MovieScreen();
              case RouteData.booking:
                return const BookingScreen();
              // case RouteData.contact:
              //   return const ContactScreen();
              case RouteData.notFound:
                return const FullWidth();
              default:
                return const HomeScreen();
            }
          } else {
            return const FullWidth();
          }
        } else if (uri.pathSegments.length == 2) {
          if (uri.pathSegments[0] == "movie") {
            int? id = int.tryParse(uri.pathSegments[1]);
            if (id == null) return const FullWidth();
            return MovieDetailScreen(id: id);
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
// String getRouteTitle(String? routeName) {
//   RouteData routeData;
//
//   if (routeName != null) {
//     final uri = Uri.parse(routeName);
//
//     if (uri.pathSegments.isNotEmpty) {
//       final pathName = uri.pathSegments.elementAt(0).toString();
//       routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);
//
//       if (routeData != RouteData.notFound) {
//         switch (routeData) {
//           case RouteData.unknown:
//             return 'Unknown';
//           case RouteData.dashboard:
//             return 'Dashboard';
//           case RouteData.user:
//             return 'User';
//           case RouteData.movie:
//             return 'Movie';
//           case RouteData.genre:
//             return 'Genre';
//           case RouteData.branch:
//             return 'Branch';
//           case RouteData.showtime:
//             return 'Showtime';
//           case RouteData.ticket:
//             return 'Ticket';
//           case RouteData.promotion:
//             return 'Promotion';
//           case RouteData.advertisement:
//             return 'Advertisement';
//           case RouteData.statistic:
//             return 'Statistic';
//           default:
//             return 'Dashboard';
//         }
//       } else {
//         return 'Unknown';
//       }
//     } else {
//       return 'Dashboard';
//     }
//   } else {
//     return 'Unknown';
//   }
// }
}
