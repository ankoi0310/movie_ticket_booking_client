import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/page_carousel_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';
import 'package:provider/provider.dart';

class MovieCarouselCard extends StatefulWidget {
  final MovieModel movie;
  final int index;

  const MovieCarouselCard({required this.movie, required this.index, Key? key}) : super(key: key);

  @override
  _MovieCarouselCardState createState() => _MovieCarouselCardState();
}

class _MovieCarouselCardState extends State<MovieCarouselCard> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<PageCarouselProvider>(
        builder: (context, pageCarouselProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * .12,
            ),
            SizedBox(
              height: size.height * .15,
              child: Align(
                alignment: Alignment.center,
                child: Image(
                  width: size.width / 2.5,
                  image: widget.movie.imageLogo.image,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            GenresFormat(widget.movie.genres, Colors.white, MainAxisAlignment.center),
            SizedBox(
              height: size.height * .005,
            ),
            StarRating(widget.movie.rating, MainAxisAlignment.center),
            SizedBox(
              height: size.height * .01,
            ),
            Container(
              width: size.width * .25,
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
                width: size.width * .35,
                // color: Theme.of(context).primaryColor,
                height: size.height * .05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    "Buy Tickets",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width / 22,
                        fontWeight: FontWeight.w400),
                  ),
                )),
            SizedBox(
              height: size.height * .06,
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
                      width: size.width * 0.5,
                      height: size.height * 0.35,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * .06,
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.movie.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width / 14,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
