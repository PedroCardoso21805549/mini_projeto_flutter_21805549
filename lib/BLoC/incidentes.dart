import "dart:async";
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';

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

  void dispose() => _controller.close();
}