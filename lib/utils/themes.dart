import 'package:flutter/material.dart';

class Themes {
  static const cPrimaryText = Color(0xFFF1F3F2);
  static const cButtonViolet = Color(0xFF775FCF);
  static const cLightViolet = Color(0xFFB6A4EC);
  static const cDarkGrey = Color(0xFF1E1E25);
  static const cLightGrey = Color(0xFF302E44);
  static const cOrange = Color(0xFFFF9800);
  static const cTransparent = Colors.transparent;

  static ThemeData basicTheme() {
    TextTheme _basicTextTheme(TextTheme base) {
      return base.copyWith(
          body1: base.headline.copyWith(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              color: Themes.cPrimaryText));
    }

    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      primaryColor: Themes.cDarkGrey,
    );
  }
}
