import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default/component/footer/footer.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default/component/header/header.dart';

class DefaultLayout extends StatefulWidget {
  final String? routeName;
  final String? jsonObject;
  final Map<String, String>? queryParameters;

  const DefaultLayout({
    Key? key,
    required this.routeName,
    required this.jsonObject,
    required this.queryParameters,
  }) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  final AuthenticationService authentacationService = AuthenticationService.instance;
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = CustomKey.scaffoldKey;
  final RouteHandler _routeHandler = RouteHandler.instance;

  late final LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<SearchingProvider>(
      builder: (context, searchingProvider, child) => Stack(
        children: [
          TooltipVisibility(
            key: _scaffoldKey,
            visible: false,
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    const Header(),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          FutureBuilder(
                            future: _routeHandler.getRouteWidget(widget.routeName,
                                jsonObject: widget.jsonObject, queryParameters: widget.queryParameters),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                _appRouterDelegate.setPathName(RouteData.notFound.name);
                                return const SizedBox();
                              }

                              if (snapshot.hasData) return snapshot.data as Widget;

                              return const SizedBox();
                            },
                          ),
                          const Footer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (loadingProvider.loading) const CustomLoadingScreen(),
        ],
      ),
    );
  }
}
