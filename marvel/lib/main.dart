import 'package:flutter/material.dart';
import 'package:marvel/models/marvel_response.dart';
import 'http/webclient_marvel.dart';

void main() {
  runApp(Lista());
}

class Lista extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaPersonagens(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListaPersonagens extends StatefulWidget {
  const ListaPersonagens({
    Key key,
  }) : super(key: key);

  @override
  _ListaPersonagensState createState() => _ListaPersonagensState();
}

class _ListaPersonagensState extends State<ListaPersonagens> {
  MarvelResponsePersonagem _response;
  final List<MarvelResponsePersonagem> personagens = [];

  void initState() {
    super.initState();
    _loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel'),
      ),
      body: Container(
        child: (_response == null
            ? LinearProgressIndicator()
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: PersonagemCard(personagem: personagens[index]));
                },
                itemCount: personagens.length,
              )),
      ),
    );
  }

  _loadApi() {
    MarvelWebClient().fetch().then((response) => setState(() {
          _response = response;
        }));
  }
}

class PersonagemCard extends StatelessWidget {
  final MarvelResponsePersonagem personagem;
  PersonagemCard({this.personagem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text('Personagem: $personagem.name'),
          Text('Descrição: $personagem.description'),
        ],
      ),
    );
  }
}
