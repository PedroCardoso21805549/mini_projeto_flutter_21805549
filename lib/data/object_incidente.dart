class ObjectIncidente {
  String titulo;
  String descricao;
  String morada;
  String data;
  String estado;

  ObjectIncidente({this.titulo, this.descricao, this.morada, this.data, this.estado});

  String get tituloIncidente{
    return titulo;
  }

  String get descricaoIncidente{
    return descricao;
  }

  String get moradaIncidente{
    return morada;
  }

  String get dataIncidente{
    return data;
  }

  String get estadoIncidente{
    return estado;
  }
}