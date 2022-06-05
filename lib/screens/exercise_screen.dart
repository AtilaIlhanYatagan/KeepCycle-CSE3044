import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise_data.dart';


class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              late String newTaskTitle;
              return Container(
                color: Colors.teal,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Add Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 30.0,
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                          cursorColor: Colors.teal,
                          onChanged: (value) {
                            newTaskTitle = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.teal),
                          ),
                          onPressed: () {
                            Provider.of<ExerciseData>(context, listen: false)
                                .addTask(newTaskTitle);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.fitness_center,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Exercise Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${Provider.of<ExerciseData>(context).taskCount} Tasks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Consumer<ExerciseData>(
                builder: (context, taskData, child) {
                  return ListView.builder(
                    itemCount: taskData.taskCount,
                    itemBuilder: (context, index) {
                      final Task task = taskData.tasks[index];
                      return ExerciseTask(
                        isChecked: task.isDone,
                        taskTile: task.name,
                        checkBoxCallBack: (checkBoxState) {
                          taskData.updateTask(task);
                        },
                        delete: () {
                          taskData.deleteTask(task);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseTask extends StatelessWidget {
  final bool isChecked;
  final String taskTile;
  final Function(bool?) checkBoxCallBack;
  final Function() delete;

  ExerciseTask({
    required this.isChecked,
    required this.taskTile,
    required this.checkBoxCallBack,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTile,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.teal,
        value: isChecked,
        onChanged: checkBoxCallBack,
      ),
      onLongPress: delete,
    );
  }
}