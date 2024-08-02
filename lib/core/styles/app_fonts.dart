import 'package:flutter/material.dart';
import 'package:spaa/core/styles/app_colors.dart';

extension CustomStyle on TextTheme {
  TextStyle get smallText => TextStyle(
      fontSize: 14.0,
      color: kTextColor,
      fontFamily: 'Open',
      fontWeight: FontWeight.w500);
  TextStyle get mediumText => TextStyle(
      fontSize: 18.0,
      color: kTextColor,
      fontFamily: 'Open',
      fontWeight: FontWeight.w500);
  TextStyle get bigText => TextStyle(
      fontSize: 22.0,
      color: kTextColor,
      fontFamily: 'Open',
      fontWeight: FontWeight.w500);
}
