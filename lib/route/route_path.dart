class RoutePath {
  final String? pathName;
  final bool isUnknown;
  final String? jsonObject;


  RoutePath.home(this.pathName) : isUnknown = false, jsonObject = null;

  RoutePath.otherPage(this.pathName) : isUnknown = false, jsonObject = null;

  RoutePath.unknown()
      : pathName = null,
        isUnknown = true,
    jsonObject = null;

  bool get isHomePage => pathName == null;

  bool get isOtherPage => pathName != null;

}
