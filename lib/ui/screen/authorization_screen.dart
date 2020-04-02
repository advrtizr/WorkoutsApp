import 'package:flutter/material.dart';
import 'package:workout_app/ui/component/rounded_button.dart';
import 'package:workout_app/utils/themes.dart';

class AuthorizationScreen extends StatefulWidget {
  static final String id = 'authorization_screen';

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: Themes.cLightGrey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Themes.cDarkGrey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                height: 60.0,
                width: _size.width,
                bgColor: Themes.cButtonViolet,
                borderColor: Themes.cTransparent,
                textColor: Themes.cLightGrey,
                text: 'sign_in_key',
                onPressed: () {
                  print('Sign In');
                },
              ),
              RoundedButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                height: 60.0,
                width: _size.width,
                bgColor: Themes.cTransparent,
                borderColor: Themes.cButtonViolet,
                textColor: Themes.cButtonViolet,
                text: 'sign_up_key',
                onPressed: () {
                  print('Sign In');
                },
              ),
              SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
