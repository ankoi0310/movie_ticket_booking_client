import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/searching_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrolling;
  const NavBar({Key? key, required this.isScrolling}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}

class _NavBarState extends State<NavBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AppBar(
      elevation: widget.isScrolling ? 1: 0,
      backgroundColor: widget.isScrolling ? Colors.white : Colors.transparent,
      scrolledUnderElevation: widget.isScrolling ? 1: 0,
      title: Container(
        width: SizeConfig.screenWidth * 0.2,
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(50),
            vertical: getProportionateScreenWidth(25)),
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
        Consumer<SearchingProvider>(
          builder: (context, searchingProvider, child) => Container(
            width: SizeConfig.screenWidth * 0.8,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(50),
                vertical: getProportionateScreenWidth(15)),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildButtonNavBar(context, title: "Trang chủ", isScrolling: widget.isScrolling),
                      buildButtonNavBar(context, title: "Phim", isScrolling: widget.isScrolling),
                      buildButtonNavBar(context, title: "Diễn viên", isScrolling: widget.isScrolling),
                      buildButtonNavBar(context, title: "Rạp/Giá vé", isScrolling: widget.isScrolling),
                      buildButtonNavBar(context, title: "Liên hệ", isScrolling: widget.isScrolling),
                      const Expanded(flex: 5, child: SizedBox(width: 100)),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: HoverBuilder(
                            builder: (isHovering) => InkWell(
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                setState(() {
                                  searchingProvider.isSearching
                                      ? searchingProvider.stopSearching()
                                      : searchingProvider.startSearching();
                                });
                              },
                              child: Icon(
                                Icons.search,
                                color: isHovering
                                    ? Theme.of(context).primaryColor
                                    :(!widget.isScrolling ? Colors.white : Colors.black),
                                size: getProportionateScreenWidth(32),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                        buildButtonNavBar(context, title: "Đăng nhập", isScrolling: widget.isScrolling)
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Expanded buildButtonNavBar(BuildContext context, {required String title, required bool isScrolling}) {
  return Expanded(
    flex: 5,
    child: HoverBuilder(
      builder: (isHovering) => InkWell(
        hoverColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {},
        child: Center(
          heightFactor: 1.5,
          child: Text(title.toUpperCase(),
              style: TextStyle(
                color: (isHovering
                    ? Theme.of(context).primaryColor
                    :  (!isScrolling ? Colors.white : Colors.black)),
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    ),
  );
}
