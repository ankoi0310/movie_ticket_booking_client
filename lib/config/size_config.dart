import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/responsive.dart';

class SizeConfig {
  static late double width;
  static late double height;
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    if (Responsive.isMobile(context)) {
      width = 720;
      height = 1280;
    } else if (Responsive.isTablet(context)) {
      width = 1280;
      height = 800;
    } else {
      width = 1920;
      height = 1080;
    }
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  double height = SizeConfig.height;

  return (inputHeight / height) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  double width = SizeConfig.width;

  return (inputWidth / width) * screenWidth;
}
