import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  final String title;
  final double width;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width, height),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: (18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
