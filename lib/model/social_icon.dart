import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class SocialIcon {
  final String image;
  final Color? color;
  final String? url;

  SocialIcon({
    required this.image,
    this.color,
    this.url,
  });
}

final List<SocialIcon> authSocicalIcons = <SocialIcon>[
  SocialIcon(
    image: 'image/social/facebook.png',
  ),
  SocialIcon(
    image: 'image/social/google.png',
  ),
];

final List<SocialIcon> socialIcons = <SocialIcon>[
  SocialIcon(
    image: 'image/social/facebook.png',
    color: const Color(0xFF3B5998),
    url: 'https://www.facebook.com/',
  ),
  SocialIcon(
    image: 'image/social/google.png',
    color: const Color(0xFF1DA1F2),
    url: 'https://www.google.com/',
  ),
];
