import 'package:workout_app/model/exercise.dart';

class WorkoutEvent {
  const WorkoutEvent();
}

class AddExercise extends WorkoutEvent {
  Exercise _exercise;

  AddExercise(this._exercise);

  Exercise get exercise => _exercise;
}

class DeleteExercise extends WorkoutEvent {
  int _index;

  DeleteExercise(this._index);

  int get index => _index;
}

class WorkoutTitleUpdate extends WorkoutEvent {
  String _title;

  WorkoutTitleUpdate(this._title);

  String get title => _title;
}

class SetDate extends WorkoutEvent {
  DateTime _date;

  SetDate(this._date);

  DateTime get date => _date;
}

class SetDone extends WorkoutEvent {
  bool _done;

  SetDone(this._done);

  bool get done => _done;
}

class ResetToIdle extends WorkoutEvent{}
