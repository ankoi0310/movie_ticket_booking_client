import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile, tablet, desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) return desktop;
        if (constraints.maxWidth >= 850) return tablet;
        return mobile;
      },
    );
  }
}
