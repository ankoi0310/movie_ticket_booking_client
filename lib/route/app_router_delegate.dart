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
    return [
      MaterialPage(
        key: const ValueKey('home'),
        child: DefaultLayout(
          routeName: pathName ?? RouteData.home.name,
        ),
      )
    ];
  }

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('auth'),
          child: DefaultLayout(routeName: RouteData.login.name),
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
    bool isLoggedIn = await _authentacationService.isLoggedIn();
    pathName = configuration.pathName;

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.home.name;
            isError = false;
          } else {
            pathName = configuration.pathName != RouteData.login.name ? configuration.pathName : RouteData.home.name;
            isError = false;
          }
        } else {
          pathName = RouteData.login.name;

          isError = false;
        }
      } else {
        pathName = configuration.pathName;
        isError = false;
      }
    } else {
      pathName = "/";
    }
    notifyListeners();
  }

  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
