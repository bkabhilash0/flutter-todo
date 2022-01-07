import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks.dart';
import 'package:todo/screens/profile_screen.dart';
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
        routes: {
          //   TodoOverviewScreen.routeName: (_) => const TodoOverviewScreen(),
          //   TodoDoneScreen.routeName: (ctx) => const TodoDoneScreen(),
          //   TodoArchiveScreen.routeName: (_) => const TodoArchiveScreen()
          ProfileScreen.routeName: (_) => const ProfileScreen()
        },
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
  bool _isLoading = false;
  bool _isError = false;
  String _errorMessage = "";

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<TasksProvider>(context, listen: false)
        .fetchTasks()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    })
        // ignore: avoid_print
        .catchError((err) {
      print(err.toString());
      setState(() {
        _isLoading = false;
        _isError = true;
        _errorMessage = err.toString();
      });
    });
    super.initState();
  }

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

  Widget _getBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_isError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Oops! Something Went Wrong Try Reloading the App...$_errorMessage",
            style: const TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return _pages[_selectedIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
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
