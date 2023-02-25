import 'package:flutter/material.dart';

class DurationFormat extends StatelessWidget {
  final int duration;
  final double fontSize;
  final Color color;
  final dynamic mainAlignment;

  const DurationFormat({Key? key, required this.duration, required this.fontSize, required this.color, required this.mainAlignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mainAlignment,
      child: Text(
        _formatDuration(duration),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }

  String _formatDuration(int duration) {
    return duration < 60 ? '$duration min' : '${duration ~/ 60} hr ${duration % 60} min';
  }
}
