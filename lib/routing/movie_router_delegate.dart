import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default_layout.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/scrolling_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/route_handler.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/route_path.dart';
import 'package:movie_ticket_booking_flutter_nlu/services/custom_navigation_key.dart';
import 'package:provider/provider.dart';

import '../layout/full_width.dart';

class MovieRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final MovieRouterDelegate _instance = MovieRouterDelegate._();

  bool? isLoggedIn = true;
  String? pathName;
  bool isError = false;

  factory MovieRouterDelegate() {
    return _instance;
  }

  MovieRouterDelegate._();

  @override
  final GlobalKey<NavigatorState> navigatorKey =
      CustomNavigationKeys.navigatorKey;

  late List<Page> _stack = [];

  List<Page> get _appStack {
    return [
      MaterialPage(
        key: const ValueKey('Home'),
        child: DefaultLayout(
          routeName: pathName ?? RouteData.home.name,
        ),
      )
    ];
  }

  /// Auth route
  List<Page> get _authStack => [
        const MaterialPage(
          key: ValueKey('Login'),
          child: Scaffold(),
        ),
      ];

  /// UnKnown Stack
  List<Page> get _unknownStack => [
        const MaterialPage(
          key: ValueKey('unknown'),
          child: FullWidth(),
        )
      ];

  @override
  // TODO: implement currentConfiguration
  RoutePath? get currentConfiguration {
    if (isError) return RoutePath.unknown();

    if (pathName == null) return RoutePath.home(RouteData.home.name);

    return RoutePath.otherPage(pathName);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      _stack = _appStack;
    } else if (isLoggedIn == false) {
      _stack = _authStack;
    } else {
      _stack = _unknownStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        pathName = null;

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration.isUnknown) {
      pathName = null;
      isError = true;
      return;
    }

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        pathName = configuration.pathName;
        isError = false;
        return;
      } else {
        isError = true;
        return;
      }
    } else {
      pathName = null;
    }
  }

  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }


}
