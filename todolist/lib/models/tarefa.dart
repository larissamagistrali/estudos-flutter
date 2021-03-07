class Tarefa {
  String _titulo;
  String _conteudo;
  bool _ok;

  Tarefa(this._titulo, this._conteudo, this._ok);

  String toStringTitulo() {
    return '$_titulo';
  }

  String toStringConteudo() {
    return '$_conteudo';
  }

  bool getOk() {
    return _ok;
  }

  void setOk(bool b) {
    _ok = b;
  }
}
