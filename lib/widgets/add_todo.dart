import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _textController = TextEditingController();

  var _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _tasksContainer = Provider.of<TasksProvider>(context, listen: false);
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(label: Text("Todo:")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        var result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2024));
                        var time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        _dateTime = DateTime(result!.year, result.month,
                            result.day, time!.hour, time.minute);
                      },
                      icon: const Icon(Icons.calendar_today_outlined)),
                  ElevatedButton(
                      onPressed: () {
                        _tasksContainer.addTask(
                            _textController.text, _dateTime);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          // shape: StadiumBorder()
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))))
                ],
              ),
            ]),
      ),
    );
  }
}
