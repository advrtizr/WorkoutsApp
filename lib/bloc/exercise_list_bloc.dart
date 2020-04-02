import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/bloc/event/exercise_list_event.dart';
import 'package:workout_app/bloc/state/exercise_list_state.dart';
import 'package:workout_app/repository/exercise_list_repository.dart';

class ExerciseListBloc extends Bloc<ExerciseListEvent, ExerciseListState> {
  ExerciseListRepository _repository;

  ExerciseListBloc(this._repository);

  @override
  ExerciseListState get initialState => ExerciseListState(_repository.exerciseList);

  @override
  Stream<ExerciseListState> mapEventToState(ExerciseListEvent event) async* {
    if (event is AddExercise) {
      _repository.add(event.model);
      yield ExerciseListState(_repository.exerciseList);
    } else if (event is DeleteExercise) {
      _repository.delete(event.index);
      yield ExerciseListState(_repository.exerciseList);
    }
  }
}
