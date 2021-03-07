import 'package:flutter/material.dart';
import 'package:todolist/models/tarefa.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefas.dart';

class Formulario extends StatelessWidget {
  final TextEditingController _tarefaController = TextEditingController();
  final TextEditingController _dataHoraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _tarefaController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _dataHoraController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Data/Hora',
                  hintText: '',
                ),
                keyboardType: TextInputType.text, // type datetime?
              ),
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () => _novaTarefa(context),
            )
          ],
        ),
      ),
    );
  }

  void _novaTarefa(BuildContext context) {
    final String _tarefa = _tarefaController.text;
    final String _dataHora = _dataHoraController.text;

    if (_tarefa != null && _dataHoraController != null) {
      final novaTarefa = Tarefa(_tarefa, _dataHora, false);
      _atualizaEstado(context, novaTarefa);
      Navigator.pop(context);
    }
  }

  _atualizaEstado(context, novaTarefa) {
    Provider.of<Tarefas>(context, listen: false).adiciona(novaTarefa);
  }
}
