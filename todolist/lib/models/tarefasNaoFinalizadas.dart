import 'package:todolist/models/tarefa.dart';
import 'package:flutter/material.dart';

class TarefasNaoFinalizadas extends ChangeNotifier {
  final List<Tarefa> _tarefasNaoFinalizadas = [];

  List<Tarefa> get tarefasNaoFinalizadas => _tarefasNaoFinalizadas;

  adiciona(Tarefa nova) {
    tarefasNaoFinalizadas.add(nova);
    notifyListeners();
  }

  remove(Tarefa tarefa) {
    tarefasNaoFinalizadas.remove(tarefa);
    notifyListeners();
  }
}
