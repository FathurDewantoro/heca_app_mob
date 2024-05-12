import 'package:flutter/material.dart';

class ScreenSize {
  static setWidth(BuildContext context, double valueFactor) {
    var screenWidth = MediaQuery.of(context).size.width;
    var result = screenWidth * valueFactor;
    return result;
  }

  static setHeight(BuildContext context, double valueFactor) {
    var screenHeight = MediaQuery.of(context).size.height;
    var result = screenHeight * valueFactor;
    return result;
  }

  static getWidth(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  static getHeight(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
}
