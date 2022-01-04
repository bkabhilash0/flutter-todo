import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:provider/provider.dart';
import 'package:todo/provider/task.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/widgets/remove_padding.dart';

class TodoItem extends StatelessWidget {
  final bool isLast;
  const TodoItem({Key? key, this.isLast = false}) : super(key: key);

  void showSnackBar(context, {required String message, required bool isError}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _task = Provider.of<Task>(context);
    final _tasksContainer = Provider.of<TasksProvider>(context, listen: false);
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        margin: EdgeInsets.only(bottom: isLast ? 30 : 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(
                DateFormat.jm().format(_task.dateTime),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              radius: 40,
              backgroundColor: Colors.blue.shade100,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _task.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(DateFormat.yMMMd().format(_task.dateTime),
                        style: Theme.of(context).textTheme.bodyText2),
                  ]),
            ),
            RemovePadding(
              child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: Colors.green,
                  value: _task.isDone,
                  onChanged: (value) {
                    _task.toggleIsChecked(value!);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            !_task.isDone
                                ? "Removing from Done Tasks"
                                : "Task is Done!",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      backgroundColor:
                          !_task.isDone ? Colors.red : Colors.green.shade600,
                      duration: const Duration(seconds: 2),
                    ));
                  }),
            ),
            const SizedBox(
              width: 4,
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(),
              onPressed: () {
                _task.toggleIsArchived();
                showSnackBar(context,
                    message: !_task.isArchived
                        ? "Removing from Archives"
                        : "Added to Archives",
                    isError: !_task.isArchived);
              },
              icon: Icon(_task.isArchived ? Icons.unarchive : Icons.archive),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text("Are you Sure?"),
                            content: const Text(
                                "Are you Sure want to Delete this Task?"),
                            actions: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  _tasksContainer.removeTask(_task.id);
                                  Navigator.of(context).pop();
                                  showSnackBar(context,
                                      isError: false,
                                      message: "Task deleted successfully!");
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  showSnackBar(context,
                                      isError: true,
                                      message: "Task not Deleted!");
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ))
          ],
        ));
  }
}
