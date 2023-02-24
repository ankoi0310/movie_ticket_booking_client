import 'package:flutter/material.dart';

class GenresFormat extends StatefulWidget {

  final List<String> genres;
  final dynamic mainAlignment;
  Color color;

  GenresFormat(this.genres, this.color, this.mainAlignment, {super.key});

  @override
  _GenresFormatState createState() => _GenresFormatState();
}

class _GenresFormatState extends State<GenresFormat> {

  @override
  Widget build(BuildContext context) {
    Widget dot = Container(
      width: 4.0,
      height: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(50.0)),
    );

    return Row(
      mainAxisAlignment: widget.mainAlignment,
      children: List.generate(widget.genres.length, (index) {
        if (index < widget.genres.length - 1) {
          return Row(
            children: [
              Text(
                widget.genres[index],
                style: TextStyle(color: widget.color, fontSize: 16),
              ),
              dot,
            ],
          );
        }
        else {
          return Text(widget.genres[index],style: TextStyle(color: widget.color,fontSize: 16),);
        }
      }),
    );
  }
}