import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/movie_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/firebase_storage_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/loading_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/description_movie_detail.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/trailer_video.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String slug;

  const MovieDetailScreen({Key? key, required this.slug}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isShowTrailerVideo = false;
  late MovieProvider movieProvider;
  late FirebaseStorageProvider firebaseProvider;
  late LoadingProvider loadingProvider;
  bool isCallApi = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    firebaseProvider =
        Provider.of<FirebaseStorageProvider>(context, listen: false);
    loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  }

  void _onTapTrailerVideo(bool isShow) {
    setState(() {
      isShowTrailerVideo = isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder(
      future: !isCallApi ? movieProvider.getMovieBySlug(widget.slug) : null,
      builder: (context, snapshotMovie) {
        if (snapshotMovie.hasData) {
          return FutureBuilder(
            future: firebaseProvider.getImages([
              movieProvider.movie!.imageVertical,
              movieProvider.movie!.imageHorizontal
            ]),
            builder: (context, snapshotImage) {
              if (snapshotImage.hasData) {
                Future.delayed(Duration.zero, () {
                  loadingProvider.setLoading(false);
                });
                return Container(
                  width: SizeConfig.screenWidth,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const Breadcrumb(
                              title: "Chi tiết phim",
                              imageUrl:
                                  "assets/image/breadcrumb_movie_screen.png",
                              description: "Mô tả chi tiết về bộ phim",
                            ),
                            DescriptionMovieDetail(
                              movie: movieProvider.movie,
                              image: firebaseProvider
                                  .mapImage[movieProvider.movie!.imageVertical],
                              onTapTrailerVideo: _onTapTrailerVideo,
                            ),
                          ],
                        ),
                      ),
                      isShowTrailerVideo
                          ? Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowTrailerVideo = false;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                          width: SizeConfig.screenWidth,
                                          height: SizeConfig.screenHeight,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 6,
                                                  spreadRadius: 5),
                                            ],
                                          )),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7,
                                        height: SizeConfig.screenHeight * 0.7,
                                        child: TrailerVideo(
                                          trailerVideoUrl:
                                              movieProvider.movie!.trailerUrl,
                                          thumbnail: firebaseProvider.mapImage[
                                              movieProvider
                                                  .movie!.imageHorizontal],
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                    ],
                  ),
                );
              } else {
                Future.delayed(Duration.zero, () {
                  loadingProvider.setLoading(true);
                  setState(() {
                    isCallApi = true;
                  });
                });
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
