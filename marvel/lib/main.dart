import 'package:flutter/material.dart';
import 'package:marvel/screens/list.dart';

void main() {
  runApp(Lista());
}

class Lista extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[900],
        accentColor: Colors.blue[900],
      ),
      home: ListaPersonagens(),
      debugShowCheckedModeBanner: false,
    );
  }
}
