import 'package:workout_app/model/exercise.dart';

class ExerciseEvent {
  const ExerciseEvent();
}

class AddSet extends ExerciseEvent {
  ExerciseSet _exerciseSet;

  AddSet(this._exerciseSet);

  ExerciseSet get exerciseSet => _exerciseSet;
}

class DeleteSet extends ExerciseEvent {
  int _index;

  DeleteSet(this._index);

  int get index => _index;
}

class ExerciseTitleUpdate extends ExerciseEvent {
  String _title;

  ExerciseTitleUpdate(this._title);

  String get title => _title;
}

class IncrementBreakTime extends ExerciseEvent {}

class DecrementBreakTime extends ExerciseEvent {}
