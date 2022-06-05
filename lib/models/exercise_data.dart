import 'dart:collection';
import 'package:flutter/foundation.dart';

class ExerciseData extends ChangeNotifier {
  final List<Task> _tasks = [];

  void addTask(newValue) {
    final task = Task(name: newValue);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }
}

class Task {
  final String name;
  bool isDone;
  Task({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}