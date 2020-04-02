import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/bloc/state/workout_list_state.dart';
import 'package:workout_app/bloc/workout_list_bloc.dart';
import 'package:workout_app/model/workout.dart';
import 'package:workout_app/ui/component/bottom_sheet_dialog.dart';
import 'package:workout_app/ui/component/square_mini_button.dart';
import 'package:workout_app/ui/screen/workout_creation_screen.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutListScreen extends StatefulWidget {
  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> with SingleTickerProviderStateMixin{
  TabController _tabController;
  var _initialIndex = 0;
  var _currentIndex = 0;
  var _leftTab = 0;
  var _rightTab = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: _initialIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Themes.cTransparent,
      context: context,
      builder: (context) => BottomSheetDialog(
        firstAction: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, WorkoutCreationScreen.id);
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    DateFormat pattern = new DateFormat('dd');
    return pattern.format(date);
  }

  String _formatWeekday(int weekday) {
    return gWeekdayList[weekday - 1];
  }

  Widget _buildUI(BuildContext context) {
    return Container(
      color: Themes.cLightGrey,
      child: BlocBuilder<WorkoutListBloc, WorkoutListState>(
        builder: (context, state) {
          if (state is InitialState) {
            return Center(
              child: Text('No data'),
            );
          }
          if (state is LoadedState) {
            var modelList = state.modelList;
            return ListView.builder(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 100.0),
              shrinkWrap: true,
              itemCount: modelList.length,
              itemBuilder: (context, index) {
                Workout _workout = modelList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          '${_formatWeekday(_workout.date.weekday)}, ${_formatDate(_workout.date)}',
                          style:
                              gDefaultTextStyle.copyWith(color: Themes.cButtonViolet, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 10.0),
                              blurRadius: 10.0,
                              color: Themes.cDarkGrey,
                            ),
                          ], borderRadius: gLargeBorderRadius, color: Themes.cDarkGrey),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  '${_workout.title}',
                                  style: gHeaderTextStyle,
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _workout.exercises.length,
                                itemBuilder: (context, index) {
                                  var _exercise = _workout.exercises[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0 ? Themes.cLightGrey : Themes.cDarkGrey,
                                      borderRadius: index + 1 == _workout.exercises.length
                                          ? gBottomBorderRadius
                                          : null,
                                    ),
                                    height: 40.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('${index + 1}. ${_exercise.title}'),
                                          Text(
                                            '${_exercise.setList.length} sets',
                                            style: gDefaultTextStyle.copyWith(color: Themes.cOrange),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, IconData icon) {
    double _width = MediaQuery.of(context).size.width * .5;
    var _backgroundColor;
    var _iconColor;
    var _borderRadius;
    if (index == _currentIndex) {
      _backgroundColor = Themes.cLightGrey;
      _iconColor = Themes.cButtonViolet;
    } else {
      _backgroundColor = Themes.cDarkGrey;
      _iconColor = Themes.cLightGrey;
    }
    if (index == _leftTab) {
      _borderRadius = BorderRadius.only(topLeft: Radius.circular(20.0));
    } else {
      _borderRadius = BorderRadius.only(topRight: Radius.circular(20.0));
    }

    return Container(
      width: _width,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: _borderRadius,
      ),
      child: Tab(
        child: Icon(
          icon,
          color: _iconColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 60.0,
          padding: EdgeInsets.only(left: 20.0, right: 10.0),
          width: _size.width,
          color: Themes.cDarkGrey,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'My workouts',
                style: gHeaderTextStyle,
              ),
              SquareMiniButton(
                size: 40.0,
                backgroundColor: Themes.cDarkGrey,
                lockedBackgroundColor: Themes.cLightGrey.withOpacity(.5),
                icon: CustomIcons.plus,
                locked: false,
                iconColor: Themes.cButtonViolet,
                onPressed: () {
                  _buildBottomSheet(context);
                },
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          indicator: BoxDecoration(),
          indicatorWeight: 0.0,
          labelPadding: EdgeInsets.all(0.0),
          tabs: <Widget>[
            _buildTab(context, _leftTab, Icons.playlist_add_check,),
            _buildTab(context, _rightTab, Icons.history,),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildUI(context),
              _buildUI(context),
            ],
          ),
        ),
      ],
    );
  }
}
