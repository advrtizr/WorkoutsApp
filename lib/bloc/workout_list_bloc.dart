import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/repository/workout_list_repository.dart';

import 'event/workout_list_event.dart';
import 'state/workout_list_state.dart';

class WorkoutListBloc extends Bloc<WorkoutListEvent, WorkoutListState> {
  WorkoutListRepository _repository;

  WorkoutListBloc(this._repository);

  @override
  WorkoutListState get initialState => InitialState();

  @override
  Stream<WorkoutListState> mapEventToState(WorkoutListEvent event) async* {
    yield LoadingState();
    if (event is AddWorkout) {
      _repository.add(event.model);
      yield LoadedState(_repository.workoutList);
    } else if (event is DeleteWorkout) {
      _repository.delete(event.index);
      yield LoadedState(_repository.workoutList);
    } else if (event is GetWorkoutList) {
      var workoutList = _repository.workoutList;
      if (workoutList.length == 0) {
        yield InitialState();
      } else {
        yield LoadedState(workoutList);
      }
    }
  }
}
