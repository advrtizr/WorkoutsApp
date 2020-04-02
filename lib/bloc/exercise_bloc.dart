import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/bloc/event/exercise_event.dart';
import 'package:workout_app/bloc/state/exercise_state.dart';
import 'package:workout_app/model/exercise.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  Exercise _exercise;

  ExerciseBloc(this._exercise);

  @override
  ExerciseState get initialState => ExerciseState(_exercise);

  @override
  Stream<ExerciseState> mapEventToState(ExerciseEvent event) async* {
    if (event is AddSet) {
      _exercise.setList.add(event.exerciseSet);
      yield ExerciseState(_exercise);
    } else if (event is DeleteSet) {
      _exercise.setList.removeAt(event.index);
      yield ExerciseState(_exercise);
    } else if (event is IncrementBreakTime) {
      _exercise.breakTime += 10000;
      yield ExerciseState(_exercise);
    } else if (event is DecrementBreakTime) {
      _exercise.breakTime -= 10000;
      yield ExerciseState(_exercise);
    } else if (event is ExerciseTitleUpdate) {
      _exercise.title = event.title;
      yield ExerciseState(_exercise);
    }
  }
}
