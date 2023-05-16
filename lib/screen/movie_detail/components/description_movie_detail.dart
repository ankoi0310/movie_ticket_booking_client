import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/duration_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/genres_format.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/star_rating.dart';

class DescriptionMovieDetail extends StatefulWidget {
  final Movie? movie;
  final Uint8List? image;
  final void Function(bool) onTapTrailerVideo;

  const DescriptionMovieDetail({Key? key, required this.movie, required this.onTapTrailerVideo, required this.image}) : super(key: key);

  @override
  State<DescriptionMovieDetail> createState() => _DescriptionMovieDetailState();
}

class _DescriptionMovieDetailState extends State<DescriptionMovieDetail> {
  @override
  Widget build(BuildContext context) {
    final appRouterDelegate = AppRouterDelegate.instance;

    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(
        right: getProportionateScreenWidth(100),
        left: getProportionateScreenWidth(100),
        top: getProportionateScreenHeight(50),
        bottom: getProportionateScreenHeight(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: getProportionateScreenHeight(600),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image.memory(widget.image!).image,
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.25), offset: Offset(0, 4), blurRadius: 6, spreadRadius: 5),
                        ],
                      ),
                    ),
                    Container(
                      height: getProportionateScreenHeight(600),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.onTapTrailerVideo(true);
                          });
                        },
                        child: const Center(
                          child: Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                      padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(100),
                        left: getProportionateScreenWidth(100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie!.name,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(60),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                            child: GenresFormat(
                                genres: widget.movie!.genres,
                                color: Colors.black.withOpacity(0.75),
                                mainAlignment: MainAxisAlignment.start,
                                fontSize: getProportionateScreenWidth(30)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getProportionateScreenHeight(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${(widget.movie!.rating / 2).toStringAsFixed(1)}/5",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getProportionateScreenWidth(30),
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      letterSpacing: 1.1,
                                    )),
                                const SizedBox(width: 10),
                                StarRating(
                                    rating: widget.movie!.rating, mainAlignment: MainAxisAlignment.start, fontSize: getProportionateScreenWidth(30)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.movie!.storyLine,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(22),
                              color: Colors.black.withOpacity(0.75),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                "Nhà sản xuất: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.movie!.producer,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Quốc gia: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.movie!.country,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Ngôn ngữ:  ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.movie!.language,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Phụ đề: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.movie!.subtitle,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Đạo diễn: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.movie!.director,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Dàn diễn viên: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                    widget.movie!.actors.length,
                                    (index) => Text(
                                      "${widget.movie!.actors[index]}${widget.movie!.actors.length == index ? "" : ", "}",
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(22),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Thời gian phim: ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              DurationFormat(
                                duration: widget.movie!.duration,
                                fontSize: getProportionateScreenWidth(22),
                                color: Colors.black.withOpacity(0.95),
                                mainAlignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(children: [
                            Align(
                              heightFactor: 1,
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  appRouterDelegate.setPathName("${PublicRouteData.ticket.name}/${widget.movie!.slug}");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                    vertical: getProportionateScreenHeight(20),
                                  ),
                                  width: getProportionateScreenWidth(250),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.notifications_active,
                                        color: Colors.white,
                                        size: getProportionateScreenWidth(26),
                                      ),
                                      SizedBox(width: getProportionateScreenWidth(20)),
                                      Text(
                                        "Đặt vé ngay".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Align(
                              heightFactor: 1,
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  widget.onTapTrailerVideo(true);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                    vertical: getProportionateScreenHeight(20),
                                  ),
                                  width: getProportionateScreenWidth(250),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.ondemand_video,
                                        color: Colors.white,
                                        size: getProportionateScreenWidth(26),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Xem trailer".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      )))
            ],
          )
        ],
      ),
    );
  }
}
