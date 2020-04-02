import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/bloc/event/exercise_set_event.dart';
import 'package:workout_app/bloc/state/exercise_set_state.dart';
import 'package:workout_app/model/exercise.dart';

class ExerciseSetBloc extends Bloc<ExerciseSetEvent, ExerciseSetState> {
  ExerciseSet _exerciseSet;

  ExerciseSetBloc(this._exerciseSet);

  @override
  ExerciseSetState get initialState => ExerciseSetInitialState(_exerciseSet);

  @override
  Stream<ExerciseSetState> mapEventToState(ExerciseSetEvent event) async* {
    if (event is IncrementRepeatCount) {
      _exerciseSet.repeatCount++;
      yield ExerciseSetInitialState(_exerciseSet);
    } else if (event is DecrementRepeatCount) {
      _exerciseSet.repeatCount--;
      yield ExerciseSetInitialState(_exerciseSet);
    } else if (event is IncrementWeight) {
      _exerciseSet.weight++;
      yield ExerciseSetInitialState(_exerciseSet);
    } else if (event is DecrementWeight) {
      _exerciseSet.weight--;
      yield ExerciseSetInitialState(_exerciseSet);
    }
  }
}
