import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/screens/todo_archive_screen.dart';
import 'package:todo/screens/todo_done_screen.dart';
import 'package:todo/screens/todo_overview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TasksProvider())],
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyText1: TextStyle(fontSize: 16, color: Colors.black),
              bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
            )),
        home: const RootPage(),
        // routes: {
        //   TodoOverviewScreen.routeName: (_) => const TodoOverviewScreen(),
        //   TodoDoneScreen.routeName: (ctx) => const TodoDoneScreen(),
        //   TodoArchiveScreen.routeName: (_) => const TodoArchiveScreen()
        // },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  void _onChange(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  final List<Widget> _pages = const [
    TodoOverviewScreen(),
    TodoDoneScreen(),
    TodoArchiveScreen()
  ];

  // Widget showPage(int index) {
  //   switch (index) {
  //     case 0:
  //       return TodoOverviewScreen();
  //     case 1:
  //       return TodoDoneScreen();
  //     case 2:
  //       return TodoArchiveScreen();
  //     default:
  //       return TodoOverviewScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archive'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onChange,
      ),
    );
  }
}
