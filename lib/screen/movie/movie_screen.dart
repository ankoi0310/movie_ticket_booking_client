import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/movies.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final firebaseProvider = Provider.of<FirebaseStorageProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);

    return FutureBuilder(
        future: movieProvider.getMoviesSearch(MovieSearch()),
        builder: (context, snapshotMovie) {
          if (snapshotMovie.hasData) {
            HttpResponse response = snapshotMovie.data as HttpResponse;
            List<Movie> movies = (response.data as List<dynamic>).map((e) => Movie.fromJson(e)).toList();
            return FutureBuilder(
                future: firebaseProvider.getImages(movies.map((e) => e.imageHorizontal).toList()),
                builder: (context, snapshotFirebase) {
                  if (snapshotFirebase.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const Breadcrumb(
                            title: "Phim",
                            imageUrl: "assets/image/breadcrumb_movie_screen.png",
                            description: "Tất cả các phim đang chiếu và sắp chiếu tại rạp phim Cinema StarLineX Entertainment",
                          ),
                          Movies(
                            movies: movies,
                            images: firebaseProvider.mapImage,
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                });
          }
          return Container();
        });
  }
}
