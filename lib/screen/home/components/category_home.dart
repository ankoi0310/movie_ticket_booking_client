import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/movie_category_card.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/movie_detail_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/bottom_nav_bar.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({Key? key}) : super(key: key);

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
            animationDuration: const Duration(milliseconds: 500),
            length: 2,
            child: Container(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * movies.length,
              color: Theme.of(context).colorScheme.background,
              child: isSearching
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color!
                                  .withOpacity(0.55),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSearching = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color!
                                        .withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color!
                                        .withOpacity(0.65),
                                  ),
                                  // disabledBorder: InputBorder.none,
                                  // enabledBorder: InputBorder.none,
                                  fillColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: SizeConfig.screenWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSearching = true;
                                    });
                                  },
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.05,
                                    width: SizeConfig.screenWidth * 0.75,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color!
                                              .withOpacity(0.95)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(20)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Search Movies...",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .color!
                                                      .withOpacity(0.95),
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          16),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Icon(
                                              Icons.search,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .color!
                                                  .withOpacity(0.95),
                                              size: 30,
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: getProportionateScreenWidth(45),
                                  height: getProportionateScreenHeight(45),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .color!
                                            .withOpacity(0.95)),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color!
                                        .withOpacity(0.95),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(25)),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: SizeConfig.screenWidth * 0.9,
                            height: SizeConfig.screenHeight * 0.055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color!),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TabBar(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(3),
                              labelPadding: const EdgeInsets.all(0),
                              labelColor: Colors.white,
                              tabs: [
                                Tab(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.play_circle_fill,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                        Text("Now Showing",
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Center(
                                    child: Text(
                                      "Coming Soon",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                              ),
                              unselectedLabelColor: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color!
                                  .withOpacity(0.65),
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(25)),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: SizeConfig.screenHeight! * 0.7,
                            child: TabBarView(
                              children: [
                                Center(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Wrap(
                                      spacing: getProportionateScreenWidth(20),
                                      runSpacing:
                                          getProportionateScreenWidth(20),
                                      children:
                                          List.generate(movies.length, (index) {
                                        return MovieCategoryCard(
                                            movie: movies[index]);
                                      }),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Wrap(
                                      spacing: getProportionateScreenWidth(20),
                                      runSpacing:
                                          getProportionateScreenWidth(20),
                                      children:
                                          List.generate(movies.length, (index) {
                                        return SizedBox(
                                            child: MovieCategoryCard(
                                                movie: movies[movies.length -
                                                    1 -
                                                    index]));
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          bottomNavigationBar: BottomNavBar()),
    );
  }
}
