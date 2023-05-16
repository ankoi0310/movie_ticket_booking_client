import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/responsive_config.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double width;
  static late double height;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    if (Responsive.isMobile(context)) {
      width = 375;
      height = 812;
    }

    if (Responsive.isTablet(context)) {
      width = 768;
      height = 1024;
    }

    if (Responsive.isDesktop(context)) {
      width = 1440;
      height = 900;
    }
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double height = SizeConfig.height;
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / height) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double width = SizeConfig.width;
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / width) * screenWidth;
}
