import 'package:workout_app/model/model.dart';

abstract class WorkoutListEvent {}

class AddWorkout extends WorkoutListEvent {
  Model _model;

  AddWorkout(this._model);

  Model get model => _model;
}

class DeleteWorkout extends WorkoutListEvent {
  int _index;

  DeleteWorkout(this._index);

  int get index => _index;
}

class GetWorkoutList extends WorkoutListEvent{}
