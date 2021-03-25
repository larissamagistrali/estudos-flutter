import 'package:flutter/material.dart';
import 'package:marvel/models/marvel_response.dart';
import 'package:marvel/http/webclient_marvel.dart';

class ListaPersonagens extends StatefulWidget {
  const ListaPersonagens({
    Key key,
  }) : super(key: key);

  @override
  _ListaPersonagensState createState() => _ListaPersonagensState();
}

class _ListaPersonagensState extends State<ListaPersonagens> {
  MarvelApiResponse _response;
  int _offset = 0;
  int _limit = 3;
  //final List<MarvelApiResponse> personagens = [];

  void initState() {
    super.initState();
    _loadApi(_offset, _limit);
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
                  return Card(
                    child: Container(
                        child: Row(
                      children: [
                        Text(
                            'Personagem: ${_response.data.results[index].name}'),
                        Text(
                            'Descrição: ${_response.data.results[index].description}'),
                      ],
                    )),
                  );
                  //if (index == _response.data.results.length) {

                  //}
                },
                itemCount: _response.data.results.length,
              )),
      ),
    );
  }

  _loadApi(offset, limit) {
    MarvelWebClient().fetch(0, 5).then((r) => setState(() {
          _response = r;
        }));
  }
}
