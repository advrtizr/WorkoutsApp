import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/bloc/event/workout_event.dart';
import 'package:workout_app/bloc/event/workout_list_event.dart';
import 'package:workout_app/bloc/state/workout_state.dart';
import 'package:workout_app/bloc/workout_bloc.dart';
import 'package:workout_app/bloc/workout_list_bloc.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/ui/component/date_picker_button.dart';
import 'package:workout_app/ui/screen/exercise_creation_screen.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutCreationScreen extends StatefulWidget {
  static String id = 'workout_creation_screen';

  @override
  _WorkoutCreationScreenState createState() => _WorkoutCreationScreenState();
}

class _WorkoutCreationScreenState extends State<WorkoutCreationScreen> {
  var _titleController = TextEditingController();
  var _fabResizeDuration = Duration(milliseconds: 250);
  var _isScrolling = false;

  WorkoutBloc _workoutBloc;
  WorkoutListBloc _workoutListBloc;

  initState() {
    super.initState();
    _workoutBloc = BlocProvider.of<WorkoutBloc>(context);
    _workoutListBloc = BlocProvider.of<WorkoutListBloc>(context);
     var title = _workoutBloc.state.model.title;
    if (title != null) {
      _titleController.text = title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _workoutBloc.add(ResetToIdle());
    super.dispose();
  }

  double _defineFabSize() {
    return _isScrolling ? 0.0 : 65.0;
  }

  Widget _buildHeader(Size size) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: size.width,
      color: Themes.cDarkGrey,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CustomIcons.cross,
                  color: Themes.cButtonViolet,
                  size: 24.0,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                'New workout',
                style: gHeaderTextStyle,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _workoutListBloc.add(AddWorkout(_workoutBloc.state.model));
              Navigator.pop(context);
            },
            child: Icon(
              CustomIcons.check,
              color: Themes.cButtonViolet,
              size: 24.0,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.cDarkGrey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(10.0),
          child: AnimatedContainer(
            duration: _fabResizeDuration,
            curve: Curves.easeInOut,
            width: _defineFabSize(),
            height: _defineFabSize(),
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Themes.cButtonViolet,
                child: Icon(
                  CustomIcons.plus,
                  color: Themes.cLightGrey,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ExerciseCreationScreen.id,
                    arguments: Exercise(),
                  );
                },
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildHeader(_size),
            Expanded(
              child: Container(
                width: _size.width,
                decoration: BoxDecoration(
                  color: Themes.cLightGrey,
                  borderRadius: gTopBorderRadius,
                ),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        _isScrolling = true;
                      });
                    }
                    if (notification is ScrollEndNotification) {
                      setState(() {
                        _isScrolling = false;
                      });
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: BlocBuilder<WorkoutBloc, WorkoutState>(
                      bloc: _workoutBloc,
                      builder: (context, state) {
                        var _workout = state.model;
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: gLargeBorderRadius, color: Themes.cDarkGrey),
                                child: TextFormField(
                                  cursorColor: Themes.cButtonViolet,
                                  controller: _titleController,
                                  onChanged: (value) {
                                    _workoutBloc.add(WorkoutTitleUpdate(value));
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Themes.cTransparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Themes.cTransparent),
                                    ),
                                    hintText: 'Название',
                                    hintStyle: gDefaultTextStyle.copyWith(
                                      color: Themes.cLightGrey,
                                    ),
                                  ),
                                  style: gDefaultTextStyle.copyWith(color: Themes.cPrimaryText),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                            ),
                            DatePickerButton(
                              onPressed: (value) {
                                _workoutBloc.add(SetDate(value));
                              },
                              initialDate: _workout.date,
                              bgColor: Themes.cDarkGrey,
                              borderColor: Themes.cTransparent,
                              textColor: Themes.cOrange,
                              height: 65.0,
                              width: _size.width,
                              padding: EdgeInsets.all(10.0),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _workout.exercises.length,
                              itemBuilder: (context, index) {
                                var _exercise = _workout.exercises[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        borderRadius: gLargeBorderRadius, color: Themes.cDarkGrey),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('${_exercise.title}'),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, ExerciseCreationScreen.id,
                                                      arguments: _exercise);
                                                },
                                                child: Icon(
                                                  CustomIcons.pencil,
                                                  color: Themes.cButtonViolet,
                                                  size: 24.0,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _exercise.setList.length,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var _exerciseSet = _exercise.setList[index];
                                            return Container(
                                              padding: EdgeInsets.all(10.0),
                                              color: index % 2 == 0
                                                  ? Themes.cLightGrey
                                                  : Themes.cTransparent,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text('Set ${index + 1}'),
                                                  Text(
                                                      '${_exerciseSet.repeatCount} x ${_exerciseSet.weight}',
                                                      style: gDefaultTextStyle.copyWith(
                                                          color: Themes.cOrange)),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
