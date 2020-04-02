import 'package:workout_app/model/exercise.dart';

class ExerciseListRepository {
  List<Exercise> _exerciseList = [];

  ExerciseListRepository();

  void add(Exercise model) {
    _exerciseList.add(model);
    print('Model added ${model.title} ${model.breakTime} ${model.setList.length}');
    print('Exercise length ${_exerciseList.length}');
  }

  void delete(int index) {
    _exerciseList.removeAt(index);
  }

  List<Exercise> get exerciseList => _exerciseList;
}
