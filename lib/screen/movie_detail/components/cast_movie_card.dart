import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_cast_model.dart';

class CastMovieCard extends StatelessWidget {
  final MovieCastModel cast;

  const CastMovieCard({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Row(
        children: [
          Container(
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: cast.photo.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenHeight(30),
          ),
          Text(
            cast.name,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
