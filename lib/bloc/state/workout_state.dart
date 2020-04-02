import 'package:workout_app/model/workout.dart';

class WorkoutState {
  Workout _model;

  WorkoutState(this._model);

  Workout get model => _model;
}
