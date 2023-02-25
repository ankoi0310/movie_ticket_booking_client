import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/movie_detail_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/duration_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class MovieCategoryCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCategoryCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.screenHeight * 0.4,
      child: InkWell(
        highlightColor: Colors.blue,
        splashColor: Colors.blue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        },
        child: Ink(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: movie.image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(4),
              ),
              StarRating(movie.rating, MainAxisAlignment.start, 16.0),
              SizedBox(
                height: getProportionateScreenHeight(2),
              ),
              SizedBox(
                  width: SizeConfig.screenWidth * 0.4,
                  height: SizeConfig.screenHeight * 0.035,
                  child: movie.name.length > 12
                      ? Marquee(
                          text: movie.name,
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 30,
                          velocity: 20.0,
                          pauseAfterRound: const Duration(seconds: 2),
                          startPadding: 0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration:
                              const Duration(milliseconds: 200),
                          decelerationCurve: Curves.easeOut,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme!.bodyMedium!.color,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          movie.name,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme!.bodyMedium!.color,
                            fontSize: getProportionateScreenWidth(20),
                            height: getProportionateScreenWidth(1.4),
                            fontWeight: FontWeight.bold,
                          ),
                        )),
              SizedBox(
                height: getProportionateScreenHeight(2),
              ),
              Row(
                children: [
                  GenresFormat(
                      genres: movie.genres.sublist(0, 1),
                      mainAlignment: MainAxisAlignment.start,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.65),
                      fontSize: getProportionateScreenWidth(14)),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(4)),
                    width: getProportionateScreenWidth(4),
                    child: Text(
                      "|",
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.65),
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ),
                  DurationFormat(
                    duration: movie.duration,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(0.65),
                    mainAlignment: Alignment.centerLeft,
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ],
              ),
              InkWell(
                highlightColor: Colors.blue,
                splashColor: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  );
                },
                child: Ink(
                  child: Container(
                    width: SizeConfig.screenWidth,
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(8)),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(8),
                        horizontal: getProportionateScreenWidth(8)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Buy tickets",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                    ),
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
