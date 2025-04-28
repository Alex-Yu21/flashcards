import 'package:flutter/material.dart';

extension ResponsiveExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double get headerSize => screenWidth * 0.096;
  double get bodySize => screenWidth * 0.048;
  double get captionSize => screenWidth * 0.032;

  TextStyle get headerStyle =>
      TextStyle(fontSize: headerSize, fontWeight: FontWeight.w600);
  TextStyle get bodyStyle => TextStyle(fontSize: bodySize);
  TextStyle get captionStyle => TextStyle(fontSize: captionSize);

  double get paddingXS => screenWidth * 0.02;
  double get paddingS => screenWidth * 0.04;
  double get paddingM => screenWidth * 0.06;
  double get paddingL => screenWidth * 0.08;
}
