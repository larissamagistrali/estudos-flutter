class Tarefa {
  String _tarefa;
  String _dataHora;
  bool _ok;

  Tarefa(this._tarefa, this._dataHora, this._ok);

  String toStringTarefa() {
    return '$_tarefa';
  }

  String toStringDataHora() {
    return '$_dataHora';
  }

  bool getOk() {
    return _ok;
  }

  void setOk(bool b) {
    _ok = b;
  }
}
