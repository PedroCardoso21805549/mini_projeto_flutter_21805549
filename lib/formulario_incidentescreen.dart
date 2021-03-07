import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';
import 'package:intl/intl.dart';

import 'data/datasource.dart';

class FormularioIncidente extends StatefulWidget {
  @override
  _FormularioIncidenteState createState() => _FormularioIncidenteState();
}

class _FormularioIncidenteState extends State<FormularioIncidente>{
  final _formKey = GlobalKey<FormState>();
  final _controllerTitulo = TextEditingController();
  final _controllerDescricao = TextEditingController();
  final _controllerMorada = TextEditingController();
  final _dataSource = DataSource.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulário Incidente"),
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
            ],
          ),
        ),
        floatingActionButton:
          FloatingActionButton(
            heroTag: "btnSave",
            onPressed: () {
              final snackbar = SnackBar(
                content: Text('O seu incidente foi submetido com sucesso.'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: (){},
                ),
              );

              if(_formKey.currentState.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                FocusScope.of(context).unfocus();

                final now = DateTime.now();
                final date = DateFormat('yyyy/MM/dd – kk:mm').format(now);

                final obj = ObjectIncidente(
                  titulo: _controllerTitulo.text,
                  descricao: _controllerDescricao.text,
                  morada: _controllerMorada.text,
                  data: date,
                  estado: "Aberto",
                );

                _dataSource.insert(obj);

                Navigator.pop(context);
                //Navigator.pop(context);
              }
            },
            tooltip: 'Guardar',
            child: Icon(Icons.save),
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