import 'package:flutter/material.dart';
import 'package:todolist/models/tarefa.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tarefasNaoFinalizadas.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final TextEditingController _tarefaController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  String _setTime, _setDate;
  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

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
                controller: _tarefaController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: 'Digite aqui sua tarefa',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dataController,
                  onSaved: (String val) {
                    _setDate = val;
                  },
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(
                    labelText: 'Data',
                    hintText: 'dd/mm/aaaa',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _horaController,
                  onSaved: (String val) {
                    _setDate = val;
                  },
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(
                    labelText: 'Hora',
                    hintText: '00:00',
                  ),
                ),
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
    final String _tarefa = _tarefaController.text;
    final String _data = _dataController.text;
    final String _hora = _horaController.text;

    if (_tarefa != "") {
      final novaTarefa = Tarefa(_tarefa, _data, _hora, false);
      _atualizaEstado(context, novaTarefa);
      Navigator.pop(context);
    }
  }

  _atualizaEstado(context, novaTarefa) {
    Provider.of<TarefasNaoFinalizadas>(context, listen: false)
        .adiciona(novaTarefa);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dataController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _horaController.text = _time;
        _horaController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dataController.text = DateFormat.yMd().format(DateTime.now());
    _horaController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }
}
