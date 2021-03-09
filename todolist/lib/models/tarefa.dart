class Tarefa {
  String _tarefa;
  String _data;
  String _hora;
  bool _ok;

  Tarefa(this._tarefa, this._data, this._hora, this._ok);

  String toStringTarefa() {
    return '$_tarefa';
  }

  String toStringDataHora() {
    return '$_data - $_hora';
  }

  bool getOk() {
    return _ok;
  }

  void setOk(bool b) {
    _ok = b;
  }
}
