import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) {
      return RoutePath.home('');
    }
    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      if (RouteData.values.any((element) => element.name == pathName)) {
        return RoutePath.otherPage(pathName, uri.queryParameters);
      }
      return RoutePath.notFound(pathName);
    }
    if (uri.pathSegments.length == 2) {
      final complexPath = '${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}';
      return RoutePath.otherPage(complexPath, uri.queryParameters);
    }

    // Handle notFound routes
    return RoutePath.notFound(null);
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse(''));
    if (configuration.isOtherPage) {
      final String query = Uri(queryParameters: configuration.queryParameters).query;
      return RouteInformation(
        uri: Uri.parse('/${configuration.pathName!}?$query'),
      );
    }

    return RouteInformation(uri: null);
  }
}
