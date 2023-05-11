import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  bool? isLoggedIn;
  String? pathName = "";
  String? jsonObject;
  Map<String, String> queryParameters = {};
  bool isError = false;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;

    RouteData.values.addAll(PublicRouteData.values);

    if (isLoggedIn == true) {
      RouteData.values.addAll(AuthRouteData.values);
    }

    return _instance;
  }

  AppRouterDelegate._();

  static AppRouterDelegate get instance => _instance;

  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  final AuthenticationService _authentacationService = AuthenticationService.instance;
  late List<Page> _stack = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey = CustomNavigationKey.navigatorKey;

  List<Page> get _appStack {
    RouteData routeData = PublicRouteData.values.firstWhere((element) => pathName!.contains(element.name), orElse: () => PublicRouteData.home);
    switch (routeData) {
      case PublicRouteData.login:
      case PublicRouteData.register:
        return [
          MaterialPage(
            key: const ValueKey('auth'),
            child: FullWidthLayout(routeName: routeData.name),
          )
        ];
      default:
        return [
          MaterialPage(
            key: const ValueKey('home'),
            child: DefaultLayout(
              routeName: pathName,
              jsonObject: jsonObject,
              queryParameters: queryParameters,
            ),
          )
        ];
    }
  }

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('auth'),
          child: isLoggedIn == true
              ? DefaultLayout(
                  routeName: pathName!,
                  jsonObject: jsonObject,
                  queryParameters: queryParameters,
                )
              : FullWidthLayout(routeName: PublicRouteData.login.name),
        ),
      ];

  /// Error Stack
  List<Page> get _errorStack => [
        MaterialPage(
          key: const ValueKey('error'),
          child: FullWidthLayout(routeName: pathName!),
        )
      ];

  @override
  // TODO: implement currentConfiguration
  RoutePath? get currentConfiguration {
    if (isError) return RoutePath.notFound(pathName);

    if (pathName == null) return RoutePath.home(PublicRouteData.home.name);

    return RoutePath.otherPage(pathName, queryParameters: queryParameters);
  }

  @override
  Widget build(BuildContext context) {
    _stack = AuthRouteData.values.map((e) => e.name).contains(pathName) && isLoggedIn == true ? _authStack : _appStack;

    _stack = isError ? _errorStack : _stack;

    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
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
    isLoggedIn = await _authentacationService.isLoggedIn();

    if (isLoggedIn == true) {
      RouteData.values.addAll(AuthRouteData.values);
    } else {
      RouteData.values.removeWhere((element) => AuthRouteData.values.contains(element));
    }

    if (configuration.isNotFound) {
      pathName = configuration.pathName;
      isError = true;
    } else if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true && configuration.pathName == PublicRouteData.login.name) {
          pathName = PublicRouteData.home.name;
        } else {
          pathName = configuration.pathName;
        }
      } else {
        pathName = configuration.pathName;
      }
      isError = false;
      queryParameters = configuration.queryParameters;
    } else {
      pathName = '/';
      isError = false;
    }
    notifyListeners();
  }

  Future<void> setPathName(String? path, {String? json, Map<String, String>? params}) async {
    pathName = path;
    jsonObject = json;
    queryParameters = params ?? {};
    if (pathName == null) {
      await setNewRoutePath(RoutePath.home(PublicRouteData.home.name));
    }

    if (!RouteData.values.map((e) => e.name).contains(pathName)) {
      isError = true;
      await setNewRoutePath(RoutePath.notFound(pathName));
    } else {
      await setNewRoutePath(RoutePath.otherPage(pathName, queryParameters: queryParameters));
    }

    notifyListeners();
  }
}

class RouteData {
  static const notFound = RouteData._('not-found');
  static const internalServerError = RouteData._('internal-server-error');

  final String name;

  static Set<RouteData> values = {
    notFound,
    internalServerError,
  };

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
  static const payment = PublicRouteData._('payment');
  static const contact = PublicRouteData._('contact');

  static Set<PublicRouteData> values = {
    home,
    login,
    register,
    movie,
    ticket,
    seat,
    checkout,
    contact,
    payment,
  };

  const PublicRouteData._(String name) : super._(name);
}

class AuthRouteData extends RouteData {
  static const profile = AuthRouteData._('profile');

  static Set<AuthRouteData> values = {
    profile,
  };

  const AuthRouteData._(String name) : super._(name);
}
