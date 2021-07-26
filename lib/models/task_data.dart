import 'package:flutter/material.dart';
import 'task.dart';
import 'dart:collection';
import 'package:todolistflutter/sqlite/db_helper.dart';

class TaskData extends ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  List<Task> _tasks = [Task(name: 'Fetching Data...')];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void getTasks() async {
    _tasks = await dbHelper.getTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await dbHelper.addTask(task);
  }

  void deleteTask(Task task) async {
    await dbHelper.delete(task.id);
  }

  void updateTask(Task task) async {
    await dbHelper.update(task);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addData(String text) {
    Task task = Task(name: text);
    addTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  void toggleCheckbox(Task task) {
    task.toggleDone();
    notifyListeners();
    updateTask(task);
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    deleteTask(task);
  }
}
