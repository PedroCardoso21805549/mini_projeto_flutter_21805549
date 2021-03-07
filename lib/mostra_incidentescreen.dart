import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';
import 'package:intl/intl.dart';

import 'data/datasource.dart';

class MostraIncidente extends StatefulWidget {
  String titulo;
  String descricao;
  String morada;
  String date;
  String estado;
  int indice;

  MostraIncidente({this.titulo, this.descricao, this.morada, this.date, this.estado, this.indice});

  @override
  _MostraIncidenteState createState() => _MostraIncidenteState();
}

class _MostraIncidenteState extends State<MostraIncidente>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerTitulo;
  TextEditingController _controllerDescricao;
  TextEditingController _controllerMorada;
  final _dataSource = DataSource.getInstance();
  final incidente = MostraIncidente();

  @override
  void initState() {
    super.initState();
    _controllerTitulo = new TextEditingController(text: incidente.titulo);
    _controllerDescricao = new TextEditingController(text: incidente.descricao);
    _controllerMorada = new TextEditingController(text: incidente.morada);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detalhe Incidente"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.title),
                title: TextFormField(
                  controller: _controllerTitulo,
                  inputFormatters: [
                    // ignore: deprecated_member_use
                    WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),
                  ],
                  validator: (value) {
                    if(value.isEmpty){
                      return "Por favor preencha este campo";
                    }
                    if(value.length > 25){
                      return "Excedeu o tamanho do título";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Título *",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: TextFormField(
                  controller: _controllerDescricao,
                  inputFormatters: [
                    // ignore: deprecated_member_use
                    WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),
                  ],
                  validator: (value) {
                    if(value.isEmpty){
                      return "Por favor preencha este campo";
                    }
                    if(value.length < 100 || value.length > 200){
                      return "A descrição deve conter entre 100 a 200 caracteres";
                    }
                    return null;
                  },
                  minLines: 4,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: "Descrição *",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add_location),
                title: TextFormField(
                  controller: _controllerMorada,
                  validator: (value) {
                    if(value.length > 60){
                      return "Excedeu o tamanho da morada";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Morada",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(incidente.date),
              ),
              ListTile(
                leading: Icon(Icons.assessment),
                title: Text(incidente.estado),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "btnSave",
                  onPressed: () {
                    final snackbar = SnackBar(
                      content: Text('O seu incidente foi editado com sucesso.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: (){},
                      ),
                    );

                    if(_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      FocusScope.of(context).unfocus();

                      if(incidente.estado != "fechado") {
                        final obj = ObjectIncidente(
                          titulo: _controllerTitulo.text,
                          descricao: _controllerDescricao.text,
                          morada: _controllerMorada.text,
                          data: incidente.date,
                          estado: "Aberto",
                        );

                        _dataSource.remove(incidente.indice);
                        _dataSource.insert(obj);
                      }

                      Navigator.pop(context);
                      //Navigator.pop(context);
                    }
                  },
                  tooltip: 'Guardar',
                  child: Icon(Icons.save),
                ),
                FloatingActionButton(
                  heroTag: "btnDelete",
                  onPressed: () {
                    final snackbar = SnackBar(
                      content: Text('O incidente selecionado foi eliminado com sucesso.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: (){},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    FocusScope.of(context).unfocus();

                    _dataSource.remove(incidente.indice);

                    Navigator.pop(context);
                  },
                  tooltip: 'Apagar',
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerTitulo.dispose();
    _controllerDescricao.dispose();
    _controllerMorada.dispose();
    super.dispose();
  }
}