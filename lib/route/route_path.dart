class RoutePath {
  final String? pathName;
  final Map<String, String> queryParameters;
  final bool isNotFound;

  RoutePath.home(this.pathName)
      : isNotFound = false,
        queryParameters = {};

  RoutePath.otherPage(
    this.pathName,
    this.queryParameters,
  ) : isNotFound = false;

  RoutePath.notFound(this.pathName)
      : isNotFound = true,
        queryParameters = {};

  bool get isHomePage => pathName == '';

  bool get isOtherPage => pathName != null;
}
