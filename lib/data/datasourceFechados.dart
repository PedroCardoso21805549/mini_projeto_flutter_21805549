class DataSourceFechados {
  final _datasourceFechados = [];
  static DataSourceFechados _instance;

  DataSourceFechados._internal();

  static DataSourceFechados getInstance() {
    if(_instance == null){
      _instance = DataSourceFechados._internal();
    }
    return _instance;
  }

  void insert(operation) => _datasourceFechados.add(operation);

  void remove(index) => _datasourceFechados.removeAt(index);

  List getAll() => _datasourceFechados;

  List getAllAsString() {
    var lista = [];
    int ind = 0;
    for (var i in _datasourceFechados){
        lista.add("${i.titulo};${i.descricao};${i.morada};${i.data};${i.estado};$ind");
        ind++;
    }
    return lista;
  }
}