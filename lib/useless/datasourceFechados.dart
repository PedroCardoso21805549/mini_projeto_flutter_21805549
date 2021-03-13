class DataSourceFechados {
  final _datasourcefechados = [];
  static DataSourceFechados _instance;

  DataSourceFechados._internal();

  static DataSourceFechados getInstance() {
    if(_instance == null){
      _instance = DataSourceFechados._internal();
    }
    return _instance;
  }

  void insert(operation) => _datasourcefechados.add(operation);

  void remove(index) => _datasourcefechados.removeAt(index);

  List getAll() => _datasourcefechados;

  List getAllAsString() {
    var lista = [];
    int ind = 0;
    for (var i in _datasourcefechados){
      lista.add("${i.titulo};${i.descricao};${i.morada};${i.data};${i.estado};$ind");
      ind++;
    }
    return lista;
  }

  String getTitulo(int indice){
    return _datasourcefechados[indice].titulo;
  }

  String getDescricao(int indice){
    return _datasourcefechados[indice].descricao;
  }

  String getMorada(int indice){
    return _datasourcefechados[indice].morada;
  }

  String getData(int indice){
    return _datasourcefechados[indice].data;
  }

  String getEstado(int indice){
    return _datasourcefechados[indice].estado;
  }

  void setEstado(int indice, String estadoNovo){
    _datasourcefechados[indice].estado = estadoNovo;
  }
}