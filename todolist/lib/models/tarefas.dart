import 'package:todolist/models/tarefa.dart';
import 'package:flutter/material.dart';

class Tarefas extends ChangeNotifier {
  final List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => _tarefas;

  adiciona(Tarefa nova) {
    tarefas.add(nova);
    notifyListeners();
  }
}
