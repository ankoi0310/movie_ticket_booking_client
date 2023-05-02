class RoutePath {
  final String? pathName;
  final bool isNotFound;

  RoutePath.home(this.pathName) : isNotFound = false;

  RoutePath.otherPage(this.pathName) : isNotFound = false;

  RoutePath.notFound(this.pathName) : isNotFound = true;

  bool get isHomePage => pathName == '';

  bool get isOtherPage => pathName != null;
}
