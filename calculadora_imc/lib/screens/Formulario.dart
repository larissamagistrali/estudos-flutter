import 'package:flutter/material.dart';

class FormularioImc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioImcState();
  }
}

class FormularioImcState extends State<FormularioImc> {
  final TextEditingController _controladorCampoPeso = TextEditingController();
  final TextEditingController _controladorCampoAltura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controladorCampoPeso,
                  decoration: InputDecoration(
                    labelText: 'Peso(kg)',
                    hintText: '80',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controladorCampoAltura,
                  decoration: InputDecoration(
                    labelText: 'Altura(m)',
                    hintText: '1.80',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      onPressed: () {
                        final peso = int.tryParse(_controladorCampoPeso.text);
                        final altura =
                            double.tryParse(_controladorCampoAltura.text);

                        if (peso != null &&
                            altura != null &&
                            peso > 0 &&
                            altura > 0) {
                          final imc = peso / (altura * altura);
                          print('Valor do imc: $imc');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (contex) {
                              return Resultado(
                                imc: imc,
                              );
                            }),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Parâmetros inválidos!'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {},
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Calcular')),
                  SizedBox(
                    width: 8,
                  ),
                  RaisedButton(
                    child: Text('Limpar'),
                    onPressed: () {
                      _controladorCampoAltura.text = '';
                      _controladorCampoPeso.text = '';
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class Resultado extends StatelessWidget {
  final double imc;

  const Resultado({Key key, this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Center(
        child: Text('O seu imc é $imc'),
      ),
    );
  }
}
