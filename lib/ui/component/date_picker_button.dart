import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class DatePickerButton extends StatefulWidget {
  DatePickerButton(
      {this.height,
      this.width,
      this.bgColor,
      this.borderColor,
      this.textColor,
      this.text,
      this.onPressed,
      this.padding,
      this.icon,
      this.initialDate});

  final double height;
  final double width;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final Icon icon;
  final DateTime initialDate;

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime _selectedDate;

  initState(){
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<DateTime> _buildDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
              accentColor: Themes.cButtonViolet,
              backgroundColor: Themes.cDarkGrey,
              dialogBackgroundColor: Themes.cDarkGrey),
          child: child,
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    DateFormat pattern = new DateFormat('dd.MM.yyyy');
    return pattern.format(date);
  }

  String _formatWeekday(int weekday) {
    print('Weekday ${weekday - 1}');
    return gWeekdayList[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: gLargeBorderRadius),
        color: widget.bgColor,
        child: InkWell(
          borderRadius: gLargeBorderRadius,
          highlightColor: Themes.cLightViolet,
          onTap: () async {
//            _selectedDate = await _buildDatePicker(context);
            _selectedDate = await _buildDatePicker(context);
            widget.onPressed(_selectedDate);
            setState(() {});
          },
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: gLargeBorderRadius,
              border: Border.all(color: widget.borderColor, width: 2.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  CustomIcons.calendar,
                  color: Themes.cButtonViolet,
                  size: 24.0,
                ),
                _selectedDate == null
                    ? Center(
                        child: Text('Choose date',
                            style: gDefaultTextStyle.copyWith(color: Themes.cButtonViolet)),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_formatDate(_selectedDate)}',
                              style: gDefaultTextStyle.copyWith(color: Themes.cOrange),
                            ),
                            Text('${_formatWeekday(_selectedDate.weekday)}',
                                style: gDefaultTextStyle.copyWith(color: Themes.cPrimaryText)),
                          ],
                        ),
                      ),
                Icon(
                  CustomIcons.next_unar,
                  color: Themes.cButtonViolet,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
