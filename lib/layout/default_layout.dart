import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/nav_bar.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/searching_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/duration_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';
import 'package:provider/provider.dart';

class DefaultLayout extends StatefulWidget {
  final Widget child;

  const DefaultLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  String query = '';
  late TextEditingController _textEditingController;
  bool isScrolling = false;
  double totalScrollDelta = 0;

  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController(text: query);
  }

  @override
  void dispose() {
    // Add code before the super
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ChangeNotifierProvider(
      create: (context) => SearchingProvider(),
      child: Consumer<SearchingProvider>(
        builder: (context, searchingProvider, child) =>
            NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            setState(() {
              if(!searchingProvider.isSearching) {
                totalScrollDelta += notification.scrollDelta!;
                isScrolling = totalScrollDelta > 50;
                print(totalScrollDelta);
              }
            });
            return true;
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: NavBar(isScrolling: isScrolling),
            body: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Stack(
                children: [
                  Container(
                    child: widget.child,
                  ),
                  searchingProvider.isSearching
                      ? Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              setState(() {
                                query = '';
                              });
                              searchingProvider.stopSearching();
                            },
                            child: Opacity(
                              opacity: 0.8,
                              child: Container(
                                height: SizeConfig.screenHeight,
                                width: SizeConfig.screenWidth,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      : Container(),
                  searchingProvider.isSearching
                      ? Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.5,
                                height: 60,
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10),
                                  vertical: getProportionateScreenHeight(10),
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: getProportionateScreenWidth(36),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(10),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _textEditingController,
                                        autofocus: true,
                                        onChanged: (value) => {
                                          setState(() {
                                            query = value;
                                            value.isNotEmpty
                                                ? searchingProvider.startSearching()
                                                : searchingProvider.stopSearching();
                                          }),
                                        },
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(22),
                                          height:
                                              getProportionateScreenHeight(2),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Tìm kiếm phim ...",
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                getProportionateScreenWidth(22),
                                            height:
                                                getProportionateScreenHeight(
                                                    1.8),
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    //   icon close search bar
                                    searchingProvider.isSearching
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                searchingProvider.stopSearching();
                                                query = '';
                                                _textEditingController.text =
                                                    '';
                                              });
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: getProportionateScreenWidth(
                                                  36),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              //   Widget list movie
                              Container(
                                width: SizeConfig.screenWidth * 0.5,
                                height: 550,
                                padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(20),
                                  left: getProportionateScreenWidth(20),
                                ),
                                color: Colors.white,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 15,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(30),
                                    bottom: getProportionateScreenHeight(20),
                                  ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) => Container(
                                    width: SizeConfig.screenWidth * 0.5,
                                    height: getProportionateScreenHeight(100),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth *
                                              0.5 *
                                              0.4,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  getProportionateScreenWidth(
                                                      10)),
                                              image: DecorationImage(
                                                image: movies[index]
                                                    .imageDesktop
                                                    .image,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(10),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                movies[index]
                                                    .name
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          26),
                                                  height:
                                                      getProportionateScreenHeight(
                                                          1.8),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        15),
                                              ),
                                              GenresFormat(
                                                  genres: movies[index].genres,
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  mainAlignment:
                                                      MainAxisAlignment.start,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          20)),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10),
                                              ),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.5 *
                                                    0.5,
                                                child: Text(
                                                  movies[index].storyLine,
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            20),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            2.2),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10),
                                              ),
                                              DurationFormat(
                                                duration:
                                                    movies[index].duration,
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        20),
                                                mainAlignment:
                                                    Alignment.centerLeft,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
