import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/firebase_storage_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/loading_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/duration_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  final List<Movie> movies;
  final Map<String, Uint8List> images;

  const Carousel({Key? key, required this.movies, required this.images})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  late int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> buildPageCarousel(BuildContext context,
        {required List<Movie> movies}) {
      return List.generate(
          movies.length,
          (index) => Container(
                width: SizeConfig.screenWidth,
                height: 695,
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 695,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.memory(
                                  widget.images[movies[index].imageHorizontal]!)
                              .image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 1000,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.7,
                      padding: const EdgeInsets.only(
                        top: 150,
                        left: 80,
                        right: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            )),
                            child: Text(
                              "Phim đang chiếu".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenWidth(20),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movies[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(80),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          StarRating(
                              movies[index].rating,
                              MainAxisAlignment.start,
                              getProportionateScreenWidth(50)),
                          const SizedBox(height: 20),
                          GenresFormat(
                            genres: movies[index].genres,
                            mainAlignment: MainAxisAlignment.start,
                            fontSize: getProportionateScreenWidth(40),
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: SizeConfig.screenWidth * 0.5,
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(30)),
                            child: Text(
                              movies[index].storyLine,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w400,
                                fontSize: getProportionateScreenWidth(20),
                                letterSpacing: 1.5,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text("Thời lượng:".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(20),
                                    letterSpacing: 1.5,
                                  )),
                              SizedBox(width: getProportionateScreenWidth(20)),
                              DurationFormat(
                                  duration: movies[index].duration,
                                  fontSize: getProportionateScreenWidth(22),
                                  color: Colors.white,
                                  mainAlignment: Alignment.centerLeft),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: getProportionateScreenWidth(250),
                            height: getProportionateScreenHeight(80),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    const IconData(0xf916,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage),
                                    size: getProportionateScreenWidth(30),
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Đặt vé ngay".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getProportionateScreenWidth(18),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
    }

    return SizedBox(
        width: SizeConfig.screenWidth,
        height: 695,
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                return true;
              },
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  currentPage = index;
                },
                children: buildPageCarousel(context, movies: widget.movies),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: SizeConfig.screenWidth,
                height: 30,
                color: Colors.black.withOpacity(0.25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    0,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          currentPage = index;
                        });
                        _pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: getProportionateScreenWidth(15),
                        height: getProportionateScreenHeight(15),
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Next Button
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeIn);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  hoverColor: Colors.transparent,
                ),
              ),
            ),

            // Previous Button
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeIn);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  hoverColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ));
  }
}
