import 'package:movie_ticket_booking_flutter_nlu/component/list_menu.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';

class DefaultLayout extends StatefulWidget {
  final String routeName;
  final String? jsonObject;

  const DefaultLayout({Key? key, required this.routeName, required this.jsonObject}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  final AuthenticationService authentacationService = AuthenticationService.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = CustomKey.scaffoldKey;
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final RouteHandler _routeHandler = RouteHandler.instance;
  String query = '';
  late TextEditingController _textEditingController;

  bool _isLoading = false;
  final name = 'Dương Nguyễn Cẩm Nhung';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: query);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDesktop = Responsive.isDesktop(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    List<Movie> movies = [];

    return Consumer<SearchingProvider>(
      builder: (context, searchingProvider, child) => Stack(
        children: [
          FutureBuilder(
            future: authentacationService.isLoggedIn(),
            builder: (context, snapshot) {
              return TooltipVisibility(
                visible: false,
                child: Scaffold(
                  key: _scaffoldKey,
                  drawer: const Sidebar(),
                  body: SafeArea(
                    child: Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              elevation: 0,
                              automaticallyImplyLeading: false,
                              scrolledUnderElevation: 0,
                              backgroundColor: Theme.of(context).colorScheme.background,
                              toolbarHeight: 90,
                              centerTitle: true,
                              title: const CustomSearchBar(),
                              bottom: const ListMenu(),
                              leadingWidth: SizeConfig.screenWidth * 0.1,
                              leading: const LogoButton(path: 'image/logo.png'),
                              // leadingWidth: SizeConfig.screenWidth * 0.2,
                              // leading: Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Row(
                              //     children: [
                              //       IconButton(
                              //         icon: const Icon(Icons.menu),
                              //         onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                              //       ),
                              //       SizedBox(width: getProportionateScreenWidth(20)),
                              //       const LogoButton(path: 'image/logo.png'),
                              //     ],
                              //   ),
                              // ),
                              actions: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Image.network(
                                    'https://robohash.org/${snapshot.data == true ? name : 'guest'}',
                                    height: 40,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                SizedBox(width: SizeConfig.screenWidth * 0.02),
                              ],
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  FutureBuilder(
                                    future: _routeHandler.getRouteWidget(widget.routeName, jsonObject: widget.jsonObject),
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
                        // searchingProvider.isSearching
                        //     ? Positioned(
                        //         top: 0,
                        //         left: 0,
                        //         right: 0,
                        //         bottom: 0,
                        //         child: InkWell(
                        //           hoverColor: Colors.transparent,
                        //           splashColor: Colors.transparent,
                        //           focusColor: Colors.transparent,
                        //           highlightColor: Colors.transparent,
                        //           overlayColor: MaterialStateProperty.all(Colors.transparent),
                        //           onTap: () {
                        //             setState(() {
                        //               query = '';
                        //             });
                        //             searchingProvider.stopSearching();
                        //           },
                        //           child: Opacity(
                        //             opacity: 0.8,
                        //             child: Container(
                        //               height: SizeConfig.screenHeight,
                        //               width: SizeConfig.screenWidth,
                        //               decoration: const BoxDecoration(
                        //                 gradient: LinearGradient(
                        //                   begin: Alignment.topCenter,
                        //                   end: Alignment.bottomCenter,
                        //                   colors: [
                        //                     Colors.black,
                        //                     Colors.black,
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ))
                        //     : Container(),
                        // searchingProvider.isSearching
                        //     ? Positioned(
                        //         top: 80,
                        //         left: 0,
                        //         right: 0,
                        //         bottom: 0,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Container(
                        //               width: SizeConfig.screenWidth * 0.5,
                        //               height: 60,
                        //               padding: EdgeInsets.symmetric(
                        //                 horizontal: getProportionateScreenWidth(10),
                        //                 vertical: getProportionateScreenHeight(10),
                        //               ),
                        //               decoration: const BoxDecoration(
                        //                 color: Colors.white,
                        //                 border: Border(
                        //                   bottom: BorderSide(
                        //                     color: Colors.grey,
                        //                     width: 1,
                        //                   ),
                        //                 ),
                        //               ),
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 crossAxisAlignment: CrossAxisAlignment.center,
                        //                 children: [
                        //                   IconButton(
                        //                     onPressed: () {},
                        //                     icon: Icon(
                        //                       Icons.search,
                        //                       color: Colors.black,
                        //                       size: getProportionateScreenWidth(36),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     width: getProportionateScreenWidth(10),
                        //                   ),
                        //                   Expanded(
                        //                     child: TextField(
                        //                       controller: _textEditingController,
                        //                       autofocus: true,
                        //                       onChanged: (value) => {
                        //                         setState(() {
                        //                           query = value;
                        //                           value.isNotEmpty ? searchingProvider.startSearching() : searchingProvider.stopSearching();
                        //                         }),
                        //                       },
                        //                       style: TextStyle(
                        //                         color: Colors.black,
                        //                         fontSize: getProportionateScreenWidth(22),
                        //                         height: getProportionateScreenHeight(2),
                        //                       ),
                        //                       decoration: InputDecoration(
                        //                         hintText: "Tìm kiếm phim ...",
                        //                         hintStyle: TextStyle(
                        //                           color: Colors.black,
                        //                           fontSize: getProportionateScreenWidth(22),
                        //                           height: getProportionateScreenHeight(1.8),
                        //                         ),
                        //                         border: InputBorder.none,
                        //                         focusedBorder: InputBorder.none,
                        //                         enabledBorder: InputBorder.none,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   //   icon close search bar
                        //                   searchingProvider.isSearching
                        //                       ? IconButton(
                        //                           onPressed: () {
                        //                             setState(() {
                        //                               searchingProvider.stopSearching();
                        //                               query = '';
                        //                               _textEditingController.text = '';
                        //                             });
                        //                           },
                        //                           icon: Icon(
                        //                             Icons.close,
                        //                             color: Colors.red,
                        //                             size: getProportionateScreenWidth(36),
                        //                           ),
                        //                         )
                        //                       : Container(),
                        //                 ],
                        //               ),
                        //             ),
                        //             //   Widget list movie
                        //             Container(
                        //               width: SizeConfig.screenWidth * 0.5,
                        //               height: 550,
                        //               padding: EdgeInsets.only(
                        //                 right: getProportionateScreenWidth(20),
                        //                 left: getProportionateScreenWidth(20),
                        //               ),
                        //               color: Colors.white,
                        //               child: GridView.builder(
                        //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //                   crossAxisCount: 1,
                        //                   childAspectRatio: 5,
                        //                   crossAxisSpacing: 10,
                        //                   mainAxisSpacing: 15,
                        //                 ),
                        //                 padding: EdgeInsets.only(
                        //                   top: getProportionateScreenHeight(30),
                        //                   bottom: getProportionateScreenHeight(20),
                        //                 ),
                        //                 itemCount: 4,
                        //                 itemBuilder: (context, index) => SizedBox(
                        //                   width: SizeConfig.screenWidth * 0.5,
                        //                   height: getProportionateScreenHeight(100),
                        //                   child: Row(
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Container(
                        //                         width: SizeConfig.screenWidth * 0.5 * 0.4,
                        //                         height: 300,
                        //                         decoration: BoxDecoration(
                        //                             borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
                        //                             image: DecorationImage(
                        //                               image: Image.asset(movies[index].imageVertical).image,
                        //                               fit: BoxFit.cover,
                        //                             )),
                        //                       ),
                        //                       SizedBox(
                        //                         width: getProportionateScreenWidth(10),
                        //                       ),
                        //                       Container(
                        //                         padding: EdgeInsets.symmetric(
                        //                           horizontal: getProportionateScreenWidth(10),
                        //                         ),
                        //                         child: Column(
                        //                           mainAxisAlignment: MainAxisAlignment.center,
                        //                           crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               movies[index].name.toUpperCase(),
                        //                               style: TextStyle(
                        //                                 color: Colors.black,
                        //                                 fontWeight: FontWeight.bold,
                        //                                 fontSize: getProportionateScreenWidth(26),
                        //                                 height: getProportionateScreenHeight(1.8),
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: getProportionateScreenHeight(15),
                        //                             ),
                        //                             GenresFormat(
                        //                                 genres: movies[index].genres,
                        //                                 color: Colors.black.withOpacity(0.8),
                        //                                 mainAlignment: MainAxisAlignment.start,
                        //                                 fontSize: getProportionateScreenWidth(20)),
                        //                             SizedBox(
                        //                               height: getProportionateScreenHeight(10),
                        //                             ),
                        //                             SizedBox(
                        //                               width: SizeConfig.screenWidth * 0.5 * 0.5,
                        //                               child: Text(
                        //                                 movies[index].storyLine,
                        //                                 style: TextStyle(
                        //                                   color: Colors.black.withOpacity(0.9),
                        //                                   fontSize: getProportionateScreenWidth(20),
                        //                                   height: getProportionateScreenHeight(2.2),
                        //                                 ),
                        //                                 maxLines: 2,
                        //                                 overflow: TextOverflow.ellipsis,
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: getProportionateScreenHeight(10),
                        //                             ),
                        //                             DurationFormat(
                        //                               duration: movies[index].duration,
                        //                               color: Colors.black,
                        //                               fontSize: getProportionateScreenWidth(20),
                        //                               mainAlignment: Alignment.centerLeft,
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       )
                        //     : Container()
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (loadingProvider.loading) const CustomLoadingScreen(),
        ],
      ),
    );
  }
}
