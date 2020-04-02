import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/bloc/event/exercise_event.dart';
import 'package:workout_app/bloc/event/exercise_set_event.dart';
import 'package:workout_app/bloc/event/workout_event.dart';
import 'package:workout_app/bloc/exercise_bloc.dart';
import 'package:workout_app/bloc/exercise_set_bloc.dart';
import 'package:workout_app/bloc/state/exercise_state.dart';
import 'package:workout_app/bloc/workout_bloc.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/ui/component/counter_display_widget.dart';
import 'package:workout_app/utils/custom_icons.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class ExerciseCreationScreen extends StatefulWidget {
  static String id = 'exercise_creation_screen';

  @override
  _ExerciseCreationScreenState createState() => _ExerciseCreationScreenState();
}

class _ExerciseCreationScreenState extends State<ExerciseCreationScreen> {
  var _titleController = TextEditingController();

  ExerciseBloc _exerciseBloc;
  WorkoutBloc _workoutBloc;

  initState() {
    super.initState();
    _workoutBloc = BlocProvider.of<WorkoutBloc>(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
                'New exercise',
                style: gHeaderTextStyle,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _workoutBloc.add(AddExercise(_exerciseBloc.state.model));
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

  String _formatTime(int value) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(value);
    DateFormat pattern = new DateFormat('mm:ss');
    return pattern.format(date);
  }

  _buildExerciseSetList(Exercise exercise) {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: exercise.setList.length,
        itemBuilder: (context, index) {
          var _exerciseSet = exercise.setList[index];
          var _exerciseSetBloc = ExerciseSetBloc(_exerciseSet);
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: BlocBuilder(
                  bloc: _exerciseSetBloc,
                  builder: (context, state) {
                    return Container(
                      decoration:
                          BoxDecoration(borderRadius: gLargeBorderRadius, color: Themes.cDarkGrey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Text(
                              'Set ${index + 1}',
                              style: gDefaultTextStyle.copyWith(color: Themes.cPrimaryText),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: CounterDisplayWidget(
                                  padding: EdgeInsets.all(20.0),
                                  title: 'reps',
                                  titleColor: Themes.cLightGrey,
                                  currentValue: _exerciseSet.repeatCount.toString(),
                                  increment: () {
                                    _exerciseSetBloc.add(IncrementRepeatCount());
                                  },
                                  decrement: () {
                                    _exerciseSetBloc.add(DecrementRepeatCount());
                                  },
                                  minLocked: _exerciseSet.repeatCount == 0,
                                  maxLocked: _exerciseSet.repeatCount >= 50,
                                ),
                              ),
                              Expanded(
                                child: CounterDisplayWidget(
                                  padding: EdgeInsets.all(20.0),
                                  title: 'kgs',
                                  titleColor: Themes.cLightGrey,
                                  currentValue: _exerciseSet.weight.toString(),
                                  increment: () {
                                    _exerciseSetBloc.add(IncrementWeight());
                                  },
                                  decrement: () {
                                    _exerciseSetBloc.add(DecrementWeight());
                                  },
                                  minLocked: _exerciseSet.weight == 0,
                                  maxLocked: _exerciseSet.weight >= 300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final Exercise exercise = ModalRoute.of(context).settings.arguments;
    _titleController.text = exercise.title;
    _exerciseBloc = ExerciseBloc(exercise);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.cDarkGrey,
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocBuilder<ExerciseBloc, ExerciseState>(
                    bloc: _exerciseBloc,
                    builder: (context, state) {
                      var _exercise = state.model;
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
                                  _exerciseBloc.add(ExerciseTitleUpdate(value));
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: CounterDisplayWidget(
                                  padding: EdgeInsets.only(
                                      left: 30.0, bottom: 20.0, right: 20.0, top: 20.0),
                                  title: 'sets',
                                  currentValue: _exercise.setList.length.toString(),
                                  increment: () {
                                    _exerciseBloc.add(AddSet(ExerciseSet(0, 0)));
                                  },
                                  decrement: () {
                                    _exerciseBloc.add(DeleteSet(_exercise.setList.length - 1));
                                  },
                                  minLocked: _exercise.setList.length == 0,
                                  maxLocked: _exercise.setList.length >= 10,
                                ),
                              ),
                              Expanded(
                                child: CounterDisplayWidget(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 20.0, right: 30.0, top: 20.0),
                                  title: 'break',
                                  currentValue: _formatTime(_exercise.breakTime),
                                  increment: () {
                                    _exerciseBloc.add(IncrementBreakTime());
                                  },
                                  decrement: () {
                                    _exerciseBloc.add(DecrementBreakTime());
                                  },
                                  minLocked: _exercise.breakTime == 0,
                                  maxLocked: _exercise.breakTime >= 300000,
                                ),
                              ),
                            ],
                          ),
                          _buildExerciseSetList(_exercise),
                        ],
                      );
                    },
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
