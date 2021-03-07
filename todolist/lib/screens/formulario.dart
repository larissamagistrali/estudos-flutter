import 'package:flutter/material.dart';
import 'package:todolist/models/tarefa.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefas.dart';

class Formulario extends StatelessWidget {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();

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
                controller: _tituloController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Título',
                  hintText: '...',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _conteudoController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: '...',
                ),
                keyboardType: TextInputType.text,
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
    final String _titulo = _tituloController.text;
    final String _conteudo = _conteudoController.text;

    if (_titulo != null && _conteudo != null) {
      final novaTarefa = Tarefa(_titulo, _conteudo, false);
      _atualizaEstado(context, novaTarefa);
      Navigator.pop(context);
    }
  }

  _atualizaEstado(context, novaTarefa) {
    Provider.of<Tarefas>(context, listen: false).adiciona(novaTarefa);
  }
}
