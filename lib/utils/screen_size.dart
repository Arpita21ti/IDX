// import 'dart:math';
// import 'package:flutter/widgets.dart';

// class ScreenSize {
//   late double _screenWidth;
//   late double _screenHeight;
//   late double _sizingReference;
//   late double _screenRatio;

//   // Initialize with MediaQuery context
//   void init(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     _screenWidth = size.width;
//     _screenHeight = size.height;
//     _screenRatio = _screenHeight / _screenWidth;
//     _calculateSizingReference();
//   }

//   void _calculateSizingReference() {
//     if (_screenRatio >= 1.2) {
//       // Portrait-like screen
//       _sizingReference =
//           sqrt(_screenWidth * _screenWidth + _screenHeight * _screenHeight);
//     } else {
//       // Landscape-like screen
//       _sizingReference = _screenWidth / 1.2;
//     }
//   }

//   // Getters for dimensions
//   double get width => _screenWidth;
//   double get height => _screenHeight;
//   double get sizingReference => _sizingReference;
//   double get ratio => _screenRatio;
// }
