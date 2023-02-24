import 'package:flutter/material.dart';


class StarRating extends StatefulWidget {

  final double rating;
  final dynamic mainAlignment;

  const StarRating(this.rating, this.mainAlignment, {super.key});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {

    Widget star(bool fill){
      return Container(
        child: Icon(
          Icons.star,
          size: 18.0,
          color: fill ? Colors.amber : Colors.grey,
        ),
      );
    }

    return Row(
      mainAxisAlignment: widget.mainAlignment,
      children: List.generate(5, (index) {
        if(index < (widget.rating / 2).round()){
          return star(true);
        }
        else
        {
          return star(false);
        }
      }),
    );
  }
}