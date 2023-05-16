import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/menu_item.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}

class _NavBarState extends State<NavBar> {
  final _appRouterDelegate = AppRouterDelegate.instance;
  final _authenticationService = AuthenticationService.instance;

  late bool isMobile;

  bool? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    isMobile = Responsive.isMobile(context);
    final searchingProvider = Provider.of<SearchingProvider>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 1,
      title: Container(
        width: SizeConfig.screenWidth * 0.2,
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(50),
          vertical: getProportionateScreenWidth(25),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            "assets/image/logo.png",
            fit: BoxFit.contain,
            width: getProportionateScreenWidth(150),
            height: getProportionateScreenHeight(150),
          ),
        ),
      ),
      actions: [
        Container(
          width: SizeConfig.screenWidth * 0.8,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(50),
            vertical: getProportionateScreenWidth(15),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                      menuItems.length,
                      (index) => Expanded(
                        flex: 5,
                        child: HoverBuilder(
                          builder: (isHovering) => InkWell(
                            hoverColor: Colors.transparent,
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            onTap: () => _appRouterDelegate.setPathName(menuItems[index].route.name),
                            child: Center(
                              heightFactor: 1.5,
                              child: Text(
                                menuItems[index].label.toUpperCase(),
                                style: TextStyle(
                                  color: isHovering ? Theme.of(context).primaryColor : Colors.black,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 5, child: SizedBox(width: 100)),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: HoverBuilder(
                          builder: (isHovering) => InkWell(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              setState(() {
                                searchingProvider.isSearching ? searchingProvider.stopSearching() : searchingProvider.startSearching();
                              });
                            },
                            child: Icon(
                              Icons.search,
                              color: isHovering ? Theme.of(context).primaryColor : Colors.black,
                              size: getProportionateScreenWidth(32),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      Expanded(
                        flex: 5,
                        child: FutureBuilder(
                            future: _authenticationService.isLoggedIn(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                isLoggedIn = snapshot.hasData && snapshot.data == true;

                                return HoverBuilder(
                                  builder: (isHovering) => InkWell(
                                    hoverColor: Colors.transparent,
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    onTap: () async {
                                      if (isLoggedIn == true) {
                                        await _authenticationService.logout();

                                        setState(() {
                                          isLoggedIn = false;
                                        });
                                        await _appRouterDelegate.setPathName(PublicRouteData.home.name);
                                      } else {
                                        await _appRouterDelegate.setPathName(PublicRouteData.login.name);
                                      }
                                    },
                                    child: Center(
                                      heightFactor: 1.5,
                                      child: Text(
                                        (isLoggedIn == true ? "Đăng xuất" : "Đăng nhập").toUpperCase(),
                                        style: TextStyle(
                                          color: (isHovering ? Theme.of(context).primaryColor : Colors.black),
                                          fontSize: getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
