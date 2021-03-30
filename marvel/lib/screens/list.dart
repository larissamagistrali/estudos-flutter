import 'package:flutter/material.dart';
import 'package:marvel/models/marvel_response.dart';
import 'package:marvel/http/webclient_marvel.dart';

import 'dialog.dart';

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
    //double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        title: Text('Marvel'),
      ),
      body: Container(
        child: (_response == null
            ? LinearProgressIndicator()
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => showMyDialog(context, _response, index),
                    child: Card(
                      child: Column(
                        children: [
                          gwtWidgetImage(index, context),
                          getWidgetName(index),
                          getWidgetDescription(index),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _response.data.results.length,
              )),
      ),
    );
  }

  Padding getWidgetName(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${_response.data.results[index].name}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.lightBlue[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding getWidgetDescription(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${_response.data.results[index].description}',
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
      ),
    );
  }

  Padding gwtWidgetImage(int index, BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              _response.data.results[index].thumbnail.getFoto(),
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
            )));
  }

  _loadApi(offset, limit) {
    MarvelWebClient().fetch(0, 5).then((r) => setState(() {
          _response = r;
        }));
  }
}
