import 'package:flutter/material.dart';
import 'package:todolist/screens/lista.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefasNaoFinalizadas.dart';
import 'package:todolist/models/tarefasFinalizadas.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TarefasNaoFinalizadas(),
        ),
        ChangeNotifierProvider(
          create: (context) => TarefasFinalizadas(),
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
