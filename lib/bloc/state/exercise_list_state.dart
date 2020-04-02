import 'package:workout_app/model/exercise.dart';

class ExerciseListState {
  List<Exercise> _modelList;

  ExerciseListState(this._modelList);

  List<Exercise> get modelList => _modelList;
}
//
//class InitialState extends ExerciseListState {}
//
//class LoadingState extends ExerciseListState {}
//
//class LoadedState extends ExerciseListState {
//  List<Exercise> _modelList;
//
//  LoadedState(this._modelList);
//
//  List<Exercise> get modelList => _modelList;
//}
//
//class ErrorState extends ExerciseListState {
//  String _message;
//
//  ErrorState(this._message);
//
//  String get message => _message;
//}
