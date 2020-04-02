import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/bloc/event/workout_event.dart';
import 'package:workout_app/bloc/state/workout_state.dart';
import 'package:workout_app/model/workout.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  Workout _workout;

  WorkoutBloc(this._workout);

  @override
  WorkoutState get initialState => WorkoutState(_workout);

  @override
  Stream<WorkoutState> mapEventToState(WorkoutEvent event) async* {
    if (event is WorkoutTitleUpdate) {
      _workout.title = event.title;
      yield WorkoutState(_workout);
    } else if (event is AddExercise) {
      _workout.exercises.add(event.exercise);
      yield WorkoutState(_workout);
    } else if (event is DeleteExercise) {
      _workout.exercises.removeAt(event.index);
      yield WorkoutState(_workout);
    } else if (event is SetDate) {
      _workout.date = event.date;
      yield WorkoutState(_workout);
    } else if (event is SetDone) {
      _workout.done = event.done;
      yield WorkoutState(_workout);
    } else if (event is ResetToIdle) {
      _workout = Workout();
      yield WorkoutState(_workout);
    }
  }
}
