import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/route_path.dart';

class MovieRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return RoutePath.home('/');
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      return RoutePath.otherPage(pathName);
    } else if (uri.pathSegments.length == 2) {
      final complexPath =
          '${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}';
      return RoutePath.otherPage(complexPath);
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'movie') return RoutePath.unknown();
      final remaining = uri.pathSegments.elementAt(1);
      final slug = remaining;

      if (slug == null) return RoutePath.unknown();
      return RoutePath.otherPage("/movie/$slug");
    }

    // Handle unknown routes
    return RoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown)
      return const RouteInformation(location: '/error');
    if (configuration.isHomePage) return const RouteInformation(location: '/');
    if (configuration.isOtherPage)
      return RouteInformation(location: '/${configuration.pathName}');

    return const RouteInformation(location: null);
  }
}
