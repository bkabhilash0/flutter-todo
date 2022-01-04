import 'package:flutter/material.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final DateTime dateTime;
  bool isDone;
  bool isArchived;

  Task(
      {required this.title,
      required this.dateTime,
      required this.id,
      this.isDone = false,
      this.isArchived = false});

  void toggleIsChecked(bool value) {
    isDone = value;
    notifyListeners();
  }

  void toggleIsArchived() {
    isArchived = !isArchived;
    notifyListeners();
  }
}
