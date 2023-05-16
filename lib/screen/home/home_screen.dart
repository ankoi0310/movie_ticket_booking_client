import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/movie_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/firebase_storage_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/loading_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/carousel.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/movies.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final firebaseProvider = Provider.of<FirebaseStorageProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getMoviesSearch(MovieSearch(movieState: MovieState.nowShowing)),
      builder: (context, snapshotMovie) {
        if (snapshotMovie.hasData) {
          HttpResponse response = snapshotMovie.data as HttpResponse;
          List<Movie> movies = (response.data as List<dynamic>).map((e) => Movie.fromJson(e)).toList();
          return FutureBuilder(
            future: firebaseProvider.getImages(movies.map((e) => e.imageHorizontal).toList()),
            builder: (context, snapshotFirebase) {
              if (snapshotFirebase.hasData) {
                Future.delayed(Duration.zero, () {
                  loadingProvider.setLoading(false);
                });
                return Column(
                  children: [
                    Carousel(
                      movies: movies,
                      images: firebaseProvider.mapImage,
                    ),
                    Movies(
                      movies: movies,
                      images: firebaseProvider.mapImage,
                    ),
                  ],
                );
              } else {
                Future.delayed(
                  Duration.zero,
                  () {
                    loadingProvider.setLoading(true);
                  },
                );
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
