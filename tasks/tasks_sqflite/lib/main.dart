import 'package:flutter/material.dart';
import 'package:flutter_tasks/database/dao/task_dao.dart';

import 'models/task.dart';
import 'screens/my_list.dart';

void main() {
  runApp(MyApp());
  // final task = Task('2', 'Teste 2', 'N');
  // TaskDao().save(task);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tasks',
      color: Colors.white,
      theme: ThemeData(
        primaryColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800], opacity: 1.0),
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.blue[700],
      ),
      home: const MyList(),
    );
  }
}
