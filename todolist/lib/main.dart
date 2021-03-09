import 'package:flutter/material.dart';
import 'package:todolist/screens/lista.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefas.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Tarefas(),
        ),
      ],
      child: ToDoList(),
    ));

class ToDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lista(),
    );
  }
}
