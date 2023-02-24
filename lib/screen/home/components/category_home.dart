import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/movie_category_card.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/movie_detail_screen.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({Key? key}) : super(key: key);

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          width: size.width,
          height: size.height * movies.length,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: size.height * 0.075,
                      width: size.width * 0.15,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .color!
                                .withOpacity(0.45)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.clear_all_rounded,
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.45),
                        size: 30,
                      ),
                    ),
                    Container(
                      height: size.height * 0.075,
                      width: size.width * 0.65,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .color!
                                .withOpacity(0.45)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search Movies...",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color!
                                        .withOpacity(0.45),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.search,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color!
                                    .withOpacity(0.35),
                                size: 30,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.055,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.45)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                      tabs: [
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.play_circle_fill,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Now Showing"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Center(
                              child: Text("Coming Soon"),
                            ),
                          ),
                        ),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                      ),
                      labelStyle: TextStyle(
                          color:
                              Theme.of(context).textTheme.titleMedium!.color!,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      unselectedLabelColor: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(0.45),
                      unselectedLabelStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .color!
                              .withOpacity(0.45),
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: size.height * 0.6,
                  child: TabBarView(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(movies.length, (index) {
                              return SizedBox(
                                  width: size.width * 0.4,
                                  height: size.height * 0.4,
                                  child:
                                      MovieCategoryCard(movie: movies[index]));
                            }),
                          ),
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(movies.length, (index) {
                              return SizedBox(
                                  width: size.width * 0.4,
                                  height: size.height * 0.4,
                                  child: MovieCategoryCard(
                                      movie:
                                          movies[movies.length - 1 - index]));
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
    );
  }
}
