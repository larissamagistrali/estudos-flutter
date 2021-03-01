import 'package:flutter/material.dart';
import 'package:calculadora_imc/screens/Formulario.dart';

void main() => runApp(CalculadoraImc());

class CalculadoraImc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),*/
      home: FormularioImc(),
    );
  }
}
