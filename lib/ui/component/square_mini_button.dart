import 'package:flutter/material.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class SquareMiniButton extends StatelessWidget {
  SquareMiniButton({
    @required this.icon,
    @required this.backgroundColor,
    @required this.lockedBackgroundColor,
    @required this.iconColor,
    @required this.onPressed,
    @required this.size,
    @required this.locked,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color lockedBackgroundColor;
  final Color iconColor;
  final Function onPressed;
  final double size;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: locked,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: gSmallBorderRadius),
        color: locked ? lockedBackgroundColor : backgroundColor,
        child: InkWell(
          borderRadius: gSmallBorderRadius,
          highlightColor: Themes.cLightViolet,
          splashColor: Themes.cLightViolet,
          onTap: onPressed,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: gSmallBorderRadius,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24.0,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
