import 'package:flutter/foundation.dart';

class ExerciseData extends ChangeNotifier {
  String name;
  bool isDone;
  ExerciseData({required this.name , this.isDone = false});
  void toggleDone() {
    isDone = !isDone;
  }
  final List<ExerciseData> exercises = [];

  void addTask(newValue) {
    final task = ExerciseData(name: newValue);
    exercises.add(task);
    notifyListeners();
  }

  void updateTask(ExerciseData task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(ExerciseData task) {
    exercises.remove(task);
    notifyListeners();
  }

  int get taskCount {
    return exercises.length;
  }

}