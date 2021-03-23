import 'package:flutter/material.dart';
import 'package:marvel/models/marvel_response.dart';

import 'http/webclient_marvel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  MarvelResponse _response;

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
      body: //_response == null
          // ? LinearProgressIndicator()
          // :
          Column(
        children: [
          Text('$_response.body'),
        ],
      ),
    );
  }

  void _loadApi() {
    MarvelWebClient().fetch().then((response) => setState(() {
          _response = response;
        }));
  }
}
