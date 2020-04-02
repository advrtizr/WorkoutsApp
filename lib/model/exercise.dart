import 'model.dart';

class Exercise extends Model {
  String title;
  int breakTime;
  List<ExerciseSet> setList;

  Exercise(){
    this.title = '';
    this.breakTime = 0;
    this.setList = [];
  }
}

class ExerciseSet {
  int repeatCount;
  int weight;

  ExerciseSet(this.repeatCount, this.weight);
}
