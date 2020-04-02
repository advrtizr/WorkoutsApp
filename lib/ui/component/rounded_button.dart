import 'package:flutter/material.dart';
import 'package:workout_app/utils/app_localizations.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    this.height,
    this.width,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.text,
    this.onPressed,
    this.padding,
    this.icon,
  });

  final double height;
  final double width;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final Icon icon;

  _buildWithText(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context).translate(text),
        style: gDefaultTextStyle.copyWith(color: textColor),
      ),
    );
  }

  _buildWithIconAndText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        icon,
        Flexible(
          child: Text(
            AppLocalizations.of(context).translate(text),
            textAlign: TextAlign.start,
            style: gDefaultTextStyle.copyWith(color: textColor),
          ),
        ),
        SizedBox(
          width: 24.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: gLargeBorderRadius),
        color: bgColor,
        child: InkWell(
          borderRadius: gLargeBorderRadius,
          highlightColor: Themes.cLightViolet,
          onTap: onPressed,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: gLargeBorderRadius,
              border: Border.all(color: borderColor, width: 2.0),
            ),
            child: icon == null ? _buildWithText(context) : _buildWithIconAndText(context),
          ),
        ),
      ),
    );
  }
}
