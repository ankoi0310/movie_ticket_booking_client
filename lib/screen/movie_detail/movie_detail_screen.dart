import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          color: Theme.of(context).colorScheme.background,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        TrailerVideo(
                            trailerVideoUrl: widget.movie.trailerVideoUrl),
                        Positioned(
                          top: size.height * 0.001,
                          left: 20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: size.width * 0.4,
                              height: size.height * 0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
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
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              widget.movie.name,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: GenresFormat(
                                widget.movie.genres,
                                Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color!
                                    .withOpacity(0.65),
                                MainAxisAlignment.center,
                                18),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      letterSpacing: 1.1,
                                    )),
                                const SizedBox(width: 10),
                                StarRating(widget.movie.rating,
                                    MainAxisAlignment.center, 28.0),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.9,
                            height: size.height * 0.55,
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(top: 10),
                            child: DescriptionMovieDetail(movie: widget.movie),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
