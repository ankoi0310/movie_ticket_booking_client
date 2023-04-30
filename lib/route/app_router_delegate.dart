import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  bool? isLoggedIn;
  String? pathName;
  bool isError = false;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;
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
    RouteData routeData = PublicRouteData.values.firstWhere((element) => element.name == pathName, orElse: () => PublicRouteData.home);
    switch (routeData) {
      case PublicRouteData.login:
      case PublicRouteData.register:
        return [
          MaterialPage(
            key: const ValueKey('home'),
            child: FullWidthLayout(routeName: routeData.name),
          )
        ];
      default:
        return [
          MaterialPage(
            key: const ValueKey('home'),
            child: DefaultLayout(routeName: routeData.name),
          )
        ];
    }
  }

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('auth'),
          child: isLoggedIn == true ? DefaultLayout(routeName: pathName!) : FullWidthLayout(routeName: PublicRouteData.login.name),
        ),
      ];

  /// Error Stack
  List<Page> get _errorStack => [
        MaterialPage(
          key: const ValueKey('unknown'),
          child: FullWidthLayout(routeName: ErrorRouteData.notFound.name),
        )
      ];

  @override
  // TODO: implement currentConfiguration
  RoutePath? get currentConfiguration {
    if (isError) return RoutePath.notFound();

    if (pathName == null) return RoutePath.home(PublicRouteData.home.name);

    return RoutePath.otherPage(pathName);
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
    pathName = configuration.pathName;

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
          if (configuration.pathName == PublicRouteData.login.name) {
            pathName = PublicRouteData.home.name;
          } else {
            pathName = configuration.pathName != PublicRouteData.login.name ? configuration.pathName : PublicRouteData.home.name;
          }
        } else {
          pathName = PublicRouteData.login.name;
        }
        pathName = configuration.pathName;
        isError = false;
      } else {
        pathName = configuration.pathName;
        isError = false;
      }
    } else {
      pathName = "/";
    }
    notifyListeners();
  }

  void setPathName(String path) {
    pathName = path;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
