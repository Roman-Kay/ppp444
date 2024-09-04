import 'package:flutter/material.dart';

abstract class AppColors {
  static const primaryColor = Color(0xFFAC68FF);
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.01, 0.365, 1],
    colors: [
      Color(0xFFAC68FF),
      Color(0xFF111111),
      Color(0xFF111111),
    ],
  );

  static const surfaceColor = Color(0xFF383838);
  static const whiteColor = Color(0xFFF3F3F3);
  static const basicWhiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF141414);
  static const greyColor = Color(0xFF8B8B8B);
  static const linesColor = Color(0xFF515151);
  static const segmentedPickerBgColor = Color(0xFF515151);
  static const placeHolderColor = Color(0xFFD9BBFF);
}
