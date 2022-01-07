import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/widgets/stat_row.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile-screen";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasksContainer = Provider.of<TasksProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(color: Colors.black54),
          ),
        ),
        Center(
            child: Container(
          height: size.height * 0.35,
          width: size.width * .9,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.account_circle),
                  radius: 25,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "ABHILASH BK",
                  style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(height: 15),
                Expanded(
                    child: Column(
                  children: [
                    StatRow(
                      title: "Pending Tasks",
                      icon: Icons.task_alt,
                      iconColor: Colors.red,
                      value: tasksContainer.pendingTasks.length.toString(),
                    ),
                    StatRow(
                      title: "Done Tasks",
                      icon: Icons.task_alt,
                      iconColor: Colors.green,
                      value: tasksContainer.doneTasks.length.toString(),
                    ),
                    StatRow(
                      title: "Archived Tasks",
                      icon: Icons.task_alt,
                      iconColor: Colors.blue,
                      value: tasksContainer.archivedTasks.length.toString(),
                    ),
                    StatRow(
                      title: "Total Tasks",
                      icon: Icons.add_chart_rounded,
                      iconColor: Colors.blue,
                      value: tasksContainer.items.length.toString(),
                    ),
                  ],
                ))
              ]),
        ))
      ],
    );
  }
}
