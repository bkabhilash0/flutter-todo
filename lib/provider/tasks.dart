import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import './task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _myTasks = [
    // Task(id: "1", title: "Go to Bed 😴", dateTime: DateTime.now()),
    // Task(id: "2", title: "Prepare for Exams 😥", dateTime: DateTime.now()),
    // Task(id: "3", title: "Go Shopping 🛍️", dateTime: DateTime.now()),
    // Task(id: "4", title: "Do Programming 😍", dateTime: DateTime.now()),
    // Task(id: "5", title: "Teach Students 🧑‍🏫", dateTime: DateTime.now()),
    // Task(id: "6", title: "Have a Nice Day! ❤️", dateTime: DateTime.now()),
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

  Future<void> fetchTasks() async {
    try {
      final todos = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      final data = json.decode(todos.body) as List;
      final requiredData = data
          .map((e) =>
              Task(id: e["id"].toString(), title: e["title"], dateTime: DateTime.now()))
          .toList();
      _myTasks = requiredData;
    } catch (e) {
      _myTasks = [];
      rethrow;
    }
  }

  void removeTask(String id) {
    _myTasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
