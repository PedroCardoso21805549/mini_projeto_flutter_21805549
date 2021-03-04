import "dart:async";
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';

class IncidentesFechados {
  DataSource dataSource = DataSource.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;

  String getAll() {
    _input.add(dataSource.getAll());
  }

  void dispose() => _controller.close();
}