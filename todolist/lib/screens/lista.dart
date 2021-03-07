import 'package:flutter/material.dart';
import 'package:todolist/screens/formulario.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefas.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Lista extends StatefulWidget {
  //final List<Tarefa> tarefas = [Tarefa('Titulo', 'Subtitulo')];
  //tirar rotulo debug?
  Lista({Key key}) : super(key: key);
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
      ),
      body: Consumer<Tarefas>(builder: (context, tarefas, child) {
        return ListView.builder(
          itemCount: tarefas.tarefas.length,
          itemBuilder: (context, indice) {
            final tarefa = tarefas.tarefas[indice];
            return Card(
              //padding?
              child: CheckboxListTile(
                //marca checkbox de todas as tarefas
                title: Text(tarefa.toStringTitulo()),
                subtitle: Text(tarefa.toStringConteudo()),
                value: tarefa.getOk(),
                onChanged: (bool value) {
                  setState(() {
                    tarefas.tarefas[indice].setOk(value);
                  });
                },
                activeColor: Colors.pink,
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Formulario();
          }));
        },
      ),
    );
  }
}
