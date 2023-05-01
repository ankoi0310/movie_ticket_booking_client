import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return RoutePath.home('');
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
      if (uri.pathSegments[0] != 'movie') return RoutePath.notFound();
      final remaining = uri.pathSegments.elementAt(1);
      final slug = remaining;

      if (slug == null) return RoutePath.notFound();
      return RoutePath.otherPage("/movie/$slug");
    }

    // Handle notFound routes
    return RoutePath.notFound();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isHomePage) return RouteInformation(uri: Uri.parse(''));
    if (configuration.isOtherPage)
      return RouteInformation(uri: Uri.parse('/${configuration.pathName!}'));

    return RouteInformation(uri: Uri.parse('/not-found'));
  }
}
