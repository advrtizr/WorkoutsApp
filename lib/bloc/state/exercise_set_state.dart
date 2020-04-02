import 'package:workout_app/model/exercise.dart';

class ExerciseSetState {
  const ExerciseSetState();
}

class ExerciseSetInitialState extends ExerciseSetState {
  ExerciseSet _model;

  ExerciseSetInitialState(this._model);

  ExerciseSet get model => _model;
}
