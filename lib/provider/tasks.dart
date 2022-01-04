import 'package:flutter/material.dart';
import './task.dart';

class TasksProvider with ChangeNotifier {
  final List<Task> _myTasks = [
    Task(id: "1", title: "Go to Bed 😴", dateTime: DateTime.now()),
    Task(id: "2", title: "Prepare for Exams 😥", dateTime: DateTime.now()),
    Task(id: "3", title: "Go Shopping 🛍️", dateTime: DateTime.now()),
    Task(id: "4", title: "Do Programming 😍", dateTime: DateTime.now()),
    Task(id: "5", title: "Teach Students 🧑‍🏫", dateTime: DateTime.now()),
    Task(id: "6", title: "Have a Nice Day! ❤️", dateTime: DateTime.now()),
  ];

  List<Task> get items {
    return [..._myTasks];
  }

  List<Task> get pendingTasks {
    return _myTasks.where((task) => !task.isDone && !task.isArchived).toList();
  }

  List<Task> get doneTasks {
    return _myTasks.where((task) => task.isDone).toList();
  }

  List<Task> get archivedTasks {
    return _myTasks.where((task) => task.isArchived).toList();
  }

  void addTask(String title, DateTime date) {
    _myTasks
        .add(Task(title: title, id: DateTime.now().toString(), dateTime: date));
    notifyListeners();
  }

  void removeTask(String id) {
    _myTasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
