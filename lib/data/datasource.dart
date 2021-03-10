import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';

class DataSource {
  final _datasource = [];
  static DataSource _instance;

  DataSource._internal();

  static DataSource getInstance() {
    if(_instance == null){
      _instance = DataSource._internal();
    }
    return _instance;
  }

  void insert(operation) => _datasource.add(operation);

  void remove(index) => _datasource.removeAt(index);

  List getAll() => _datasource;

  List getAllAsString() {
    var lista = [];
    int ind = 0;
    for (var i in _datasource){
        lista.add("${i.tituloIncidente};${i.descricaoIncidente};${i.moradaIncidente};${i.dataIncidente};${i.estadoIncidente};$ind");
        ind++;
    }
    return lista;
  }

  ObjectIncidente getObject(int indice) {
    return _datasource[indice];
  }

  String getTitulo(int indice){
    return _datasource[indice].tituloIncidente;
  }

  String getDescricao(int indice){
    return _datasource[indice].descricaoIncidente;
  }

  String getMorada(int indice){
    return _datasource[indice].moradaIncidente;
  }

  String getData(int indice){
    return _datasource[indice].dataIncidente;
  }

  String getEstado(int indice){
    return _datasource[indice].estadoIncidente;
  }

  void setEstado(int indice, String estadoNovo){
    _datasource[indice].estado = estadoNovo;
  }
}