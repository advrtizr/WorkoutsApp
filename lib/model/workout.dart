import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/model.dart';

class Workout extends Model {
  String title;
  DateTime date;
  bool repeatable;
  bool done;
  List<Exercise> exercises = [];

  Workout();
}
