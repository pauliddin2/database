import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todolistflutter/models/task_data.dart';
import 'package:flutter_alert/flutter_alert.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
                text: task.name,
                checked: task.isDone,
                toggleCheckbox: (bool checked) {
                  taskData.toggleCheckbox(task);
                },
                textTouch: () {
                  taskData.toggleCheckbox(task);
                },
                deleteTask: () {
                  showAlert(
                    context: context,
                    title: "Delete task?",
                    actions: [
                      AlertAction(
                        text: "Delete",
                        isDestructiveAction: true,
                        onPressed: () {
                          taskData.removeTask(task);
                        },
                      ),
                    ],
                    cancelable: true,
                  );
                });
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
