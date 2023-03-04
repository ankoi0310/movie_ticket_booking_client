import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/description_movie_detail.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/trailer_video.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class MovieDetailScreen extends StatefulWidget {
  static const routeName = "/movie_detail";

  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    movie = movies.firstWhere((element) => element.id == id);

    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chi tiết phim',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
              fontSize: getProportionateScreenWidth(32),
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
                  TrailerVideo(trailerVideoUrl: movie.trailerVideoUrl),
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
                          image: movie.image.image,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenWidth(50)),
                    child: Text(
                      movie.name,
                      style: TextStyle(
                        color:
                            Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: getProportionateScreenWidth(45),
                        fontWeight: FontWeight.bold,
                        height: getProportionateScreenWidth(1.5),
                        letterSpacing: getProportionateScreenWidth(1.1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                    child: GenresFormat(
                        genres: movie.genres,
                        color: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .color!
                            .withOpacity(0.65),
                        mainAlignment: MainAxisAlignment.center,
                        fontSize: getProportionateScreenWidth(30)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getProportionateScreenHeight(3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "${(movie.rating / 2).toStringAsFixed(1)}/5",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .color,
                              fontSize: getProportionateScreenWidth(50),
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 1.1,
                            )),
                        const SizedBox(width: 10),
                        StarRating(movie.rating,
                            MainAxisAlignment.center, getProportionateScreenWidth(50)),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.9,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(top: 10),
                    child: DescriptionMovieDetail(movie: movie),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Booking Ticket Button
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: getProportionateScreenHeight(70),
          width: SizeConfig.screenWidth,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/booking_ticket',
                  arguments: movie);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Mua vé'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontSize: getProportionateScreenWidth(28),
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
