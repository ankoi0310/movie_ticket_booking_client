import 'package:flutter/material.dart';

class DurationFormat extends StatelessWidget {
  final int duration;
  final double fontSize;
  final Color color;
  final dynamic mainAlignment;

  const DurationFormat({
    Key? key,
    required this.duration,
    required this.fontSize,
    required this.color,
    required this.mainAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(duration),
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        letterSpacing: 1.5,
      ),
    );
  }

  static String formatDuration(int duration) {
    return duration < 60 ? '$duration phút' : '${duration ~/ 60} tiếng ${duration % 60} phút';
  }
}
