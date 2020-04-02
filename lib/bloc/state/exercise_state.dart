import 'package:workout_app/model/exercise.dart';

class ExerciseState {
  Exercise _model;

  ExerciseState(this._model);

  Exercise get model => _model;
}

//class InitialState extends ExerciseState {
//  Exercise _model;
//
//  InitialState(this._model);
//
//  Exercise get model => _model;
//}
//
//class LoadingState extends ExerciseState {}
//
//class LoadedState extends ExerciseState {
//  Exercise _model;
//
//  LoadedState(this._model);
//
//  Exercise get model => _model;
//}
//
//class ErrorState extends ExerciseState {
//  String _message;
//
//  ErrorState(this._message);
//
//  String get message => _message;
//}
