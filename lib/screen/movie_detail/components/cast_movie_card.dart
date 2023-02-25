import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_cast_model.dart';

class CastMovieCard extends StatelessWidget {
  final MovieCastModel cast;

  const CastMovieCard({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: cast.photo.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Text(
            cast.name,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
