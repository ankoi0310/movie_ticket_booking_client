import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/cast_movie_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/cast_movie_card.dart';

class DescriptionMovieDetail extends StatefulWidget {
  final MovieModel movie;

  const DescriptionMovieDetail({Key? key, required this.movie})
      : super(key: key);

  @override
  State<DescriptionMovieDetail> createState() => _DescriptionMovieDetailState();
}

class _DescriptionMovieDetailState extends State<DescriptionMovieDetail> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cốt truyện",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: getProportionateScreenWidth(34),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .01,
          ),
          ExpandableText(
              widget.movie.storyLine,
            readLessText: 'Ít hơn',
            readMoreText: 'Nhiều hơn',
            textAlign: TextAlign.left,
            trim: 5,
            trimType: TrimType.lines,
            linkTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: getProportionateScreenWidth(26),
              fontWeight: FontWeight.bold,
            ),

            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color
                  ?.withOpacity(0.45),
              fontSize: getProportionateScreenWidth(26),
              height: 1.5,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Dàn diễn viên",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: getProportionateScreenWidth(34),
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CastMovieScreen(casts: widget.movie.castList))
                  );
                },
                child: Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: getProportionateScreenWidth(26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .01,
          ),
          Column(
            children: List.generate(3, (index) {
              return CastMovieCard(cast: widget.movie.castList[index]);
            }),
          )
        ],
      ),
    );
  }
}
