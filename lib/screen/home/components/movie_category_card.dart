import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/movie_detail_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class MovieCategoryCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCategoryCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: movie.image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StarRating(movie.rating, MainAxisAlignment.start, 16.0),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.4,
              height: 30,
              child:movie.name.length > 12 ? Marquee(
                text: movie.name,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 30,
                velocity:20.0,
                pauseAfterRound: const Duration(seconds: 2),
                startPadding: 0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 200),
                decelerationCurve: Curves.easeOut,
                style: TextStyle(
                  color: Theme.of(context).textTheme!.bodyMedium!.color,
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ) : Text(
                movie.name,
                style: TextStyle(
                  color: Theme.of(context).textTheme!.bodyMedium!.color,
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ),
            const SizedBox(
              height: 5,
            ),
            // GenresFormat(movie.genres, Theme.of(context).textTheme.bodyMedium!.color!)
          ],
        ),
      ),
    );
  }
}
