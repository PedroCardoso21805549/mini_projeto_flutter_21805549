import "dart:async";
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';

class Incidentes {
  DataSource dataSource = DataSource.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;

  String getAll() {
    _input.add(dataSource.getAll());
  }

  String getAllAsString(){
    _input.add(dataSource.getAllAsString());
  }

  List getAllAsStringAsList(){
    _input.add(dataSource.getAllAsString());
  }

  ObjectIncidente getObject(int indice){
    _input.add(dataSource.getObject(indice));
  }

  String getTitulo(int indice){
    _input.add(dataSource.getTitulo(indice));
  }

  String getDescricao(int indice){
    _input.add(dataSource.getDescricao(indice));
  }

  String getMorada(int indice){
    _input.add(dataSource.getMorada(indice));
  }

  String getData(int indice){
    _input.add(dataSource.getData(indice));
  }

  String getEstado(int indice){
    _input.add(dataSource.getEstado(indice));
  }

  void setEstado(int indice, String estadoNovo){
    dataSource.setEstado(indice, estadoNovo);
  }

  void remove(int indice){
    dataSource.remove(indice);
  }

  void insert(String titulo, String descricao, String morada, String data, String estado,){
    final obj = ObjectIncidente(
      titulo: titulo,
      descricao: descricao,
      morada: morada,
      data: data,
      estado: estado,
    );
    dataSource.insert(obj);
  }

  void alter(String titulo, String descricao, String morada, String data, String estado, int indice){
    final obj = ObjectIncidente(
      titulo: titulo,
      descricao: descricao,
      morada: morada,
      data: data,
      estado: estado,
    );
    dataSource.alter(indice, obj);
  }

  void dispose() => _controller.close();
}