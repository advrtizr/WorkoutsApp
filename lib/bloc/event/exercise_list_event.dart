import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/model.dart';

abstract class ExerciseListEvent {
  const ExerciseListEvent();
}

class AddExercise extends ExerciseListEvent {
  Model _model;

  AddExercise(this._model);

  Model get model => _model;
}

class DeleteExercise extends ExerciseListEvent {
  int _index;

  DeleteExercise(this._index);

  int get index => _index;
}

class AddExerciseSet extends ExerciseListEvent {
  int _index;
  ExerciseSet _exerciseSet;

  AddExerciseSet(this._index, this._exerciseSet);

  ExerciseSet get exerciseSet => _exerciseSet;

  int get index => _index;
}

class DeleteExerciseSet extends ExerciseListEvent {
  int _index;
  int _exerciseSetIndex;

  DeleteExerciseSet(this._index, this._exerciseSetIndex);

  int get exerciseSetIndex => _exerciseSetIndex;

  int get index => _index;
}
