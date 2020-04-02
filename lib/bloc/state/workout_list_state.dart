import 'package:workout_app/model/workout.dart';

abstract class WorkoutListState {
  const WorkoutListState();
}

class InitialState extends WorkoutListState {}

class LoadingState extends WorkoutListState {}

class LoadedState extends WorkoutListState {
  List<Workout> _modelList;

  LoadedState(this._modelList);

  List<Workout> get modelList => _modelList;
}
