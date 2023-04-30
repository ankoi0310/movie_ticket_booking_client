class RoutePath {
  final String? pathName;
  final bool isNotFound;

  RoutePath.home(this.pathName) : isNotFound = false;

  RoutePath.otherPage(this.pathName) : isNotFound = false;

  RoutePath.notFound()
      : pathName = null,
        isNotFound = true;

  bool get isHomePage => pathName == null;

  bool get isOtherPage => pathName != null;
}
