import 'dart:math';

import 'package:flutter/material.dart';

class StyleGlobalVariables {
  static double _screenWidth = 0; // To hold the screen width
  static double _screenHeight = 0; // To hold the screen height
  static double _sizingReference = 0; // To hold the screen sizing reference
  static double _screenRatio = 0;

  static void setContext(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    _screenHeight = size.height;
    _screenRatio = size.height / size.width;
    setSizingReference();
  }

  static void setSizingReference() {
    if (_screenRatio >= 1.2) {
      _sizingReference =
          sqrt(_screenWidth * _screenWidth + _screenHeight * _screenHeight);
    } else if (_screenRatio < 1.2) {
      _sizingReference = _screenWidth / 1.2;
    }
  }

  // Getters for screen Width and Height
  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get screenSizingReference => _sizingReference;
  static double get screenSizingRatio => _sizingReference;

// TODO : Use these only under the theme model and theme provider.
// Remove at later stages.
// Do not generate dependencies.

  // Colors to be used in app
  static const Color primaryColor = Color(0xff900909); //df9297

  // static const Color accentColor = Color(0xFFEB1555);
  // static const Color backgroundColor = Color(0xFFFFFFFF);
  // static const Color textColor = Color(0xFF8D8E98);
  static const Color buttonBgColor = Color(0xffFFCA02);
  // static const Color cardColor = Color.fromARGB(148, 235, 254, 114);
  // static const Color navBarColor = Color(0xff424349);
  // static const Color navBarIconBackgroundColor = Color(0xff24252B);
  static const Color inactiveTextFieldBackgroundColor = Color(0xffE6E5E5);
  static const Color activeTextFieldBackgroundColor = Color(0xffAAA5A5);
  static const Color primaryErrorColor = Colors.red;
  static const Color accentErrorColor = Colors.redAccent;
  static const Color primaryTextfieldInputBorderColor = Colors.black;
}
