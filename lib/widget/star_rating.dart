import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double rating;
  final dynamic mainAlignment;
  final double fontSize;

  const StarRating({
    Key? key,
    required this.rating,
    this.mainAlignment,
    required this.fontSize,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    Widget star(bool fill) {
      return Container(
        margin: const EdgeInsets.only(top: 3.0),
        child: Icon(
          Icons.star,
          size: widget.fontSize,
          color: fill ? Colors.amber : Colors.grey,
        ),
      );
    }

    return Row(
      mainAxisAlignment: widget.mainAlignment,
      children: List.generate(5, (index) {
        if (index < (widget.rating / 2).round()) {
          return star(true);
        } else {
          return star(false);
        }
      }),
    );
  }
}
