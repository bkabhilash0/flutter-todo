import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/widgets/title.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoArchiveScreen extends StatelessWidget {
  static String routeName = "/archive";
  const TodoArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myTasks = Provider.of<TasksProvider>(context).archivedTasks;
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrimaryTitle(
          title: "Archive",
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: Scrollbar(
            child: ListView.builder(
              itemBuilder: (_, index) {
                return ChangeNotifierProvider.value(
                  value: myTasks[index],
                  child: const TodoItem(),
                );
              },
              itemCount: myTasks.length,
            ),
          ),
        )
      ],
    )));
  }
}
