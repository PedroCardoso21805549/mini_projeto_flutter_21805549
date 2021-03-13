import "dart:async";
import 'file:///C:/Users/cmjff/mini_projeto_flutter_21805549/lib/useless/datasourceFechados.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';

class IncidentesFechados {
  DataSourceFechados dataSourceFechados = DataSourceFechados.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;

  String getAll() {
    _input.add(dataSourceFechados.getAll());
  }

  String getAllAsString(){
    _input.add(dataSourceFechados.getAllAsString());
  }

  List getAllAsStringAsList(){
    _input.add(dataSourceFechados.getAllAsString());
  }

  ObjectIncidente getObject(int indice){
    _input.add(dataSourceFechados.getAll()[indice]);
  }

  String getTitulo(int indice){
    _input.add(dataSourceFechados.getTitulo(indice));
  }

  String getDescricao(int indice){
    _input.add(dataSourceFechados.getDescricao(indice));
  }

  String getMorada(int indice){
    _input.add(dataSourceFechados.getMorada(indice));
  }

  String getData(int indice){
    _input.add(dataSourceFechados.getData(indice));
  }

  String getEstado(int indice){
    _input.add(dataSourceFechados.getEstado(indice));
  }

  void setEstado(int indice, String estadoNovo){
    dataSourceFechados.setEstado(indice, estadoNovo);
  }

  void remove(int indice){
    dataSourceFechados.remove(indice);
  }

  void insert(String titulo, String descricao, String morada, String data, String estado,){
    final obj = ObjectIncidente(
      titulo: titulo,
      descricao: descricao,
      morada: morada,
      data: data,
      estado: estado,
    );
    dataSourceFechados.insert(obj);
  }

  void dispose() => _controller.close();
}