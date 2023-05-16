import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

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
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      imagePath: socialIcon.image,
      onPressed: () {
        print('onPressed');
      },
    );
  }
}
