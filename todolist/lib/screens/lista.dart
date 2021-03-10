import 'package:flutter/material.dart';
import 'package:todolist/models/tarefasFinalizadas.dart';
import 'package:todolist/screens/formulario.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefasNaoFinalizadas.dart';

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
      body: Consumer2<TarefasNaoFinalizadas, TarefasFinalizadas>(
          builder: (context, tarefasNaoFinalizadas, tarefasFinalizadas, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Tarefas não concluídas"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tarefasNaoFinalizadas.tarefasNaoFinalizadas.length,
                itemBuilder: (context, indice) {
                  final tarefa =
                      tarefasNaoFinalizadas.tarefasNaoFinalizadas[indice];
                  return Card(
                    //padding?
                    child: CheckboxListTile(
                      //marca checkbox de todas as tarefas
                      title: Text(tarefa.toStringTarefa()),
                      subtitle: Text(tarefa.toStringDataHora()),
                      value: tarefa.getOk(),
                      onChanged: (bool value) {
                        setState(() {
                          tarefasNaoFinalizadas.tarefasNaoFinalizadas[indice]
                              .setOk(value);
                        });
                        tarefasFinalizadas.adiciona(tarefasNaoFinalizadas
                            .tarefasNaoFinalizadas[indice]);
                        tarefasNaoFinalizadas.remove(tarefasNaoFinalizadas
                            .tarefasNaoFinalizadas[indice]);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Tarefas concluídas"),
            ),
            Expanded(
              child: Consumer<TarefasFinalizadas>(
                  builder: (context, tarefasFinalizadas, child) {
                return ListView.builder(
                  itemCount: tarefasFinalizadas.tarefasFinalizadas.length,
                  itemBuilder: (context, indice) {
                    final tarefa =
                        tarefasFinalizadas.tarefasFinalizadas[indice];
                    return Card(
                      //padding?
                      child: CheckboxListTile(
                        //marca checkbox de todas as tarefas
                        title: Text(tarefa.toStringTarefa()),
                        subtitle: Text(tarefa.toStringDataHora()),
                        value: tarefa.getOk(),
                        onChanged: (bool value) {
                          setState(() {
                            tarefasFinalizadas.tarefasFinalizadas[indice]
                                .setOk(value);
                          });
                          tarefasNaoFinalizadas.adiciona(
                              tarefasFinalizadas.tarefasFinalizadas[indice]);
                          tarefasFinalizadas.remove(
                              tarefasFinalizadas.tarefasFinalizadas[indice]);
                        },
                        activeColor: Colors.blue,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
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
