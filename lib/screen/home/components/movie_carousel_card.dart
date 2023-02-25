import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/page_carousel_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/duration_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';
import 'package:provider/provider.dart';

class MovieCarouselCard extends StatefulWidget {
  final MovieModel movie;
  final int index;

  const MovieCarouselCard({required this.movie, required this.index, Key? key})
      : super(key: key);

  @override
  _MovieCarouselCardState createState() => _MovieCarouselCardState();
}

class _MovieCarouselCardState extends State<MovieCarouselCard> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<PageCarouselProvider>(
        builder: (context, pageCarouselProvider, child) {
      return Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: Image(
                  width: SizeConfig.screenWidth * 0.4,
                  image: widget.movie.imageLogo.image,
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            GenresFormat(
                genres: widget.movie.genres,
                color: Colors.white,
                mainAlignment: MainAxisAlignment.center,
                fontSize: getProportionateScreenWidth(18)),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            StarRating(widget.movie.rating, MainAxisAlignment.center, 20.0),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            DurationFormat(
                duration: widget.movie.duration,
                color: Colors.white,
                mainAlignment: Alignment.center,
                fontSize: getProportionateScreenWidth(16)),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Container(
              width: SizeConfig.screenWidth * .25,
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Container(
                width: SizeConfig.screenWidth * .35,
                // color: Theme.of(context).primaryColor,
                height: SizeConfig.screenHeight * .05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    "Buy Tickets",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.screenWidth / 22,
                        fontWeight: FontWeight.w400),
                  ),
                )),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 1.0, end: 1.2),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: pageCarouselProvider.currentPage == widget.index
                      ? value
                      : 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image(
                      image: widget.movie.image.image,
                      width: SizeConfig.screenWidth * 0.5,
                      height: SizeConfig.screenHeight * 0.35,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.movie.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.screenWidth / 14,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
