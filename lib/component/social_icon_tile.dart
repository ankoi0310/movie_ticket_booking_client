import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';

class SocialIconTile extends StatelessWidget {
  const SocialIconTile({
    super.key,
    required this.socialIcon,
    this.size = 30,
  });

  final SocialIcon socialIcon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      socialIcon.icon,
      size: getProportionateScreenWidth(size),
      color: socialIcon.color,
    );
  }
}
