import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/description_movie_detail.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/trailer_video.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isShowTrailerVideo = false;
  late MovieModel movie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movie = movies.firstWhere((element) => element.id == widget.id);
  }

  void _onTapTrailerVideo(bool isShow) {
    setState(() {
      isShowTrailerVideo = isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    // int id = ModalRoute.of(context)!.settings.arguments as int;
    // movie = movies.firstWhere((element) => element.id == id);

    SizeConfig().init(context);
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
                  imageUrl: "assets/image/breadcrumb_movie_screen.png",
                  description: "Mô tả chi tiết về bộ phim",
                ),
                DescriptionMovieDetail(
                    movie: movie,
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
                                color: Colors.black.withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: Offset(0, 4),
                                      blurRadius: 6,
                                      spreadRadius: 5),
                                ],
                              )),
                          Container(
                            width: SizeConfig.screenWidth * 0.7,
                            height: SizeConfig.screenHeight * 0.7,
                            child: TrailerVideo(
                              trailerVideoUrl: movie.trailerVideoUrl,
                              thumbnail: movie.imageDesktop,
                            ),
                          ),
                        ],
                      )),
                )
              : Container(),
        ],
      ),
    );
  }
}
