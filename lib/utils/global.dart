import 'package:flutter/material.dart';
import 'package:workout_app/utils/themes.dart';

const gDefaultTextStyle = TextStyle(
  color: Themes.cDarkGrey,
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

const gHeaderTextStyle = TextStyle(
  color: Themes.cPrimaryText,
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
);

const gSmallBorderRadius = BorderRadius.all(
  Radius.circular(10.0),
);

const gLargeBorderRadius = BorderRadius.all(
  Radius.circular(20.0),
);

const gTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20.0),
  topRight: Radius.circular(20.0),
);

const gBottomBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(20.0),
  bottomRight: Radius.circular(20.0),
);

const gWeekdayList = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
