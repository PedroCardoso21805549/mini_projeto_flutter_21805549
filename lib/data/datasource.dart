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
        lista.add("${i.titulo};${i.descricao};${i.morada};${i.data};${i.estado};$ind");
        ind++;
    }
    return lista;
  }
}