import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcon {
  final IconData icon;
  final Color color;
  final String url;

  SocialIcon({required this.icon, required this.color, required this.url});
}

final List<SocialIcon> registerSocicalIcons = <SocialIcon>[
  SocialIcon(
    icon: FontAwesomeIcons.facebook,
    color: const Color(0xFF3B5998),
    url: 'https://www.facebook.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.twitter,
    color: const Color(0xFF1DA1F2),
    url: 'https://twitter.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.google,
    color: const Color(0xFFDB4437),
    url: 'https://www.google.com/',
  ),
];

final List<SocialIcon> loginSocicalIcons = <SocialIcon>[
  SocialIcon(
    icon: FontAwesomeIcons.facebook,
    color: const Color(0xFF3B5998),
    url: 'https://www.facebook.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.twitter,
    color: const Color(0xFF1DA1F2),
    url: 'https://twitter.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.google,
    color: const Color(0xFFDB4437),
    url: 'https://www.google.com/',
  )
];

final List<SocialIcon> socialIcons = <SocialIcon>[
  SocialIcon(
    icon: FontAwesomeIcons.facebook,
    color: const Color(0xFF3B5998),
    url: 'https://www.facebook.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.twitter,
    color: const Color(0xFF1DA1F2),
    url: 'https://twitter.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.instagram,
    color: const Color(0xFFC13584),
    url: 'https://www.instagram.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.linkedin,
    color: const Color(0xFF0077B5),
    url: 'https://www.linkedin.com/',
  ),
  SocialIcon(
    icon: FontAwesomeIcons.youtube,
    color: const Color(0xFFCD201F),
    url: 'https://www.youtube.com/',
  ),
];
