import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/title.dart';
import 'package:todo/widgets/todo_item.dart';

class TodoOverviewScreen extends StatelessWidget {
  static String routeName = "/overview";
  const TodoOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksContainer = Provider.of<TasksProvider>(context);
    final myTasks = tasksContainer.pendingTasks;
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const PrimaryTitle(
          title: "Task",
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, index) {
              return ChangeNotifierProvider.value(
                value: myTasks[index],
                child: TodoItem(
                  isLast: index == myTasks.length - 1,
                ),
              );
            },
            itemCount: myTasks.length,
          ),
        ),
        // const SizedBox(height: 30,)
      ])),
      floatingActionButton: Draggable(
        childWhenDragging: Container(),
        onDragEnd: (details) => print(details.offset),
        feedback: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.edit,
              color: Colors.black,
            )),
        child: FloatingActionButton(
            child: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => const AddTodo());
            }),
      ),
    );
  }
}
