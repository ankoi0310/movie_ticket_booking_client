import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Story line",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          ExpandableText(
              widget.movie.storyLine,
            readLessText: 'Show less',
            readMoreText: 'Show more',
            textAlign: TextAlign.left,
            trim: 5,
            trimType: TrimType.lines,
            linkTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color
                  ?.withOpacity(0.45),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: size.height * .04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Cast movie",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .01,
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
