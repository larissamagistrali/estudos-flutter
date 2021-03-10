import 'package:todolist/models/tarefa.dart';
import 'package:flutter/material.dart';

class TarefasFinalizadas extends ChangeNotifier {
  final List<Tarefa> _tarefasFinalizadas = [];

  List<Tarefa> get tarefasFinalizadas => _tarefasFinalizadas;

  adiciona(Tarefa nova) {
    tarefasFinalizadas.add(nova);
    notifyListeners();
  }

  remove(Tarefa tarefa) {
    tarefasFinalizadas.remove(tarefa);
    notifyListeners();
  }
}
