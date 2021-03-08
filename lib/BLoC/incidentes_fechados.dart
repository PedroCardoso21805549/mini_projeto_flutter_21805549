import "dart:async";
import 'package:mini_projeto_flutter_21805549/data/datasourceFechados.dart';

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

  void dispose() => _controller.close();
}