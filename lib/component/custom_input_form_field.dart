import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';

Padding buildInputFormField({
  required String title,
  required Icon icon,
  required bool obscureText,
  required TextEditingController controller,
  required FocusNode focusNode,
  required Function(String) validator,
  required Function(String) onFieldSubmitted,
}) {
  return Padding(
    padding: EdgeInsets.only(
      top: getProportionateScreenHeight(10),
      bottom: getProportionateScreenHeight(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        TextFormField(
          autocorrect: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          controller: controller,
          focusNode: focusNode,
          validator: (value) {
            return validator(value!);
          },
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(prefixIcon: icon),
        ),
      ],
    ),
  );
}
