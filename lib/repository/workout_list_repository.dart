import 'package:workout_app/model/workout.dart';

class WorkoutListRepository {
  List<Workout> _workoutList = [];

  WorkoutListRepository();

  void add(Workout model) {
    _workoutList.add(model);
    print('Repo length ${_workoutList.length}');
  }

  void delete(int index) {
    _workoutList.removeAt(index);
  }

  List<Workout> get workoutList => _workoutList;
}
