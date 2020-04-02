import 'package:flutter/material.dart';
import 'package:workout_app/ui/component/rounded_button.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class BottomSheetDialog extends StatelessWidget {
  BottomSheetDialog({this.firstAction, this.secondAction});

  final Function firstAction;
  final Function secondAction;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Themes.cDarkGrey,
        borderRadius: gTopBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RoundedButton(
            width: _size.width,
            height: 60.0,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            text: 'new_workout_key',
            bgColor: Themes.cLightGrey,
            borderColor: Themes.cTransparent,
            textColor: Themes.cPrimaryText,
            onPressed: firstAction,
            icon: Icon(
              CustomIcons.plus,
              size: 24.0,
              color: Themes.cButtonViolet,
            ),
          ),
//          RoundedButton(
//            width: _size.width,
//            height: 60.0,
//            padding: EdgeInsets.symmetric(vertical: 10.0),
//            text: 'new_exercise_key',
//            bgColor: Themes.cLightGrey,
//            borderColor: Themes.cTransparent,
//            textColor: Themes.cPrimaryText,
//            onPressed: secondAction,
//            icon: Icon(
//              CustomIcons.plus,
//              size: 24.0,
//              color: Themes.cOrange,
//            ),
//          ),
          RoundedButton(
            width: _size.width,
            height: 60.0,
            padding: EdgeInsets.only(top: 10.0),
            text: 'cancel_key',
            bgColor: Themes.cTransparent,
            borderColor: Themes.cTransparent,
            textColor: Themes.cLightGrey,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
