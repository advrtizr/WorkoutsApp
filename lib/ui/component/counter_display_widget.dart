import 'package:flutter/material.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

import 'square_mini_button.dart';

class CounterDisplayWidget extends StatefulWidget {
  CounterDisplayWidget({
    @required this.padding,
    @required this.title,
    this.titleColor = Themes.cDarkGrey,
    @required this.increment,
    @required this.decrement,
    @required this.currentValue,
    @required this.minLocked,
    @required this.maxLocked,
  });

  final EdgeInsets padding;
  final String title;
  final Color titleColor;
  final Function increment;
  final Function decrement;
  final String currentValue;
  final bool minLocked;
  final bool maxLocked;

  @override
  _CounterDisplayWidgetState createState() => _CounterDisplayWidgetState();
}

class _CounterDisplayWidgetState extends State<CounterDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '${widget.currentValue}',
            style: gDefaultTextStyle.copyWith(color: Themes.cOrange, fontSize: 30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SquareMiniButton(
                size: 40.0,
                backgroundColor: Themes.cButtonViolet,
                lockedBackgroundColor: Themes.cButtonViolet.withOpacity(.5),
                icon: CustomIcons.remove,
                locked: widget.minLocked,
                iconColor: Themes.cLightGrey,
                onPressed: widget.decrement,
              ),
              Text(
                '${widget.title}',
                style: gDefaultTextStyle.copyWith(color: widget.titleColor),
              ),
              SquareMiniButton(
                size: 40.0,
                backgroundColor: Themes.cButtonViolet,
                lockedBackgroundColor: Themes.cButtonViolet.withOpacity(.5),
                icon: CustomIcons.close,
                locked: widget.maxLocked,
                iconColor: Themes.cLightGrey,
                onPressed: widget.increment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
