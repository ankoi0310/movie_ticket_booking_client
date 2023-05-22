import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_loading_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_search_bar.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/footer.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/list_menu.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default/component/notification_button.dart';

import 'component/avatar.dart';

class DefaultLayout extends StatefulWidget {
  final String? routeName;
  final String? jsonObject;
  final Map<String, String> queryParameters;

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
  final double _seacrhBarHeight = 90;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Consumer<SearchingProvider>(
      builder: (context, searchingProvider, child) => Stack(
        children: [
          TooltipVisibility(
            visible: false,
            child: Scaffold(
              key: _scaffoldKey,
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      scrolledUnderElevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      toolbarHeight: _seacrhBarHeight,
                      centerTitle: true,
                      title: const CustomSearchBar(),
                      bottom: const ListMenu(),
                      leadingWidth: SizeConfig.screenWidth * 0.1,
                      leading: LogoButton(
                        path: 'image/logo.png',
                        onPressed: () => _appRouterDelegate.setPathName(PublicRouteData.home.name),
                      ),
                      actions: [
                        FutureBuilder(
                          future: authentacationService.isLoggedIn(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data == true) {
                              return Row(
                                children: [
                                  const NotificationButton(),
                                  SizedBox(width: getProportionateScreenWidth(20)),
                                  const Avatar(),
                                ],
                              );
                            }

                            return TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () => _appRouterDelegate.setPathName(PublicRouteData.login.name),
                              child: const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 0.02),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          FutureBuilder(
                            future: _routeHandler.getRouteWidget(widget.routeName, jsonObject: widget.jsonObject, queryParameters: widget.queryParameters),
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
