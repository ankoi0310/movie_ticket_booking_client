import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/description_movie_detail.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/trailer_video.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Movie detail',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),

          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
        ),
        body: Container(
          width: SizeConfig.screenWidth,
          color: Theme.of(context).colorScheme.background,
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TrailerVideo(trailerVideoUrl: widget.movie.trailerVideoUrl),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: SizeConfig.screenHeight * 0.3,
                      width: SizeConfig.screenWidth * 0.4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          Theme.of(context).brightness == Brightness.dark
                              ? BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 8,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              : BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 8,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: widget.movie.image.image,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
                    child: Text(
                      widget.movie.name,
                      style: TextStyle(
                        color:
                            Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: getProportionateScreenWidth(26),
                        fontWeight: FontWeight.bold,
                        height: getProportionateScreenWidth(1.5),
                        letterSpacing: getProportionateScreenWidth(1.1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenHeight(3)),
                    child: GenresFormat(
                        genres: widget.movie.genres,
                        color: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .color!
                            .withOpacity(0.65),
                        mainAlignment: MainAxisAlignment.center,
                        fontSize: getProportionateScreenWidth(16)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenHeight(3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "${(widget.movie.rating / 2).toStringAsFixed(1)}/5",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .color,
                              fontSize: getProportionateScreenWidth(28),
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 1.1,
                            )),
                        const SizedBox(width: 10),
                        StarRating(widget.movie.rating,
                            MainAxisAlignment.center, getProportionateScreenWidth(28)),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.9,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(top: 10),
                    child: DescriptionMovieDetail(movie: widget.movie),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Booking Ticket Button
        bottomNavigationBar: Container(
          height: getProportionateScreenHeight(50),
          width: SizeConfig.screenWidth,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/booking_ticket',
                  arguments: widget.movie);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Booking Ticket'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.bold,
                  height: getProportionateScreenHeight(1.5),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
