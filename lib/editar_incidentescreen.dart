import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:intl/intl.dart';

class EditarIncidenteScreen extends StatefulWidget {
  final int indice;

  EditarIncidenteScreen({Key key, this.indice}) : super(key: key);

  @override
  _EditarIncidenteScreenState createState() => _EditarIncidenteScreenState();
}

class _EditarIncidenteScreenState extends State<EditarIncidenteScreen>{
  final _formKey = GlobalKey<FormState>();
  var _titulo = "";
  var _descricao = "";
  var _morada = "";
  final incidentes = Incidentes();

  @override
  Widget build(BuildContext context) {
    incidentes.getAll();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Editar Incidente"),
        ),
        body: StreamBuilder(
          initialData: [],
          stream: incidentes.output,
          // ignore: missing_return
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                if(widget.indice == index) {
                  var titulo = snapshot.data[index].tituloIncidente;
                  var descricao = snapshot.data[index].descricaoIncidente;
                  var morada = snapshot.data[index].moradaIncidente;
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.title),
                          title: TextFormField(
                            initialValue: titulo,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor preencha este campo";
                              }
                              _titulo = value;
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                            ],
                            decoration: InputDecoration(
                              hintText: "Título *",
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.description),
                          title: TextFormField(
                            initialValue: descricao,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor preencha este campo";
                              }
                              if (value.length < 100) {
                                return "A descrição deve conter entre 100 a 200 caracteres";
                              }
                              _descricao = value;
                              return null;
                            },
                            minLines: 4,
                            maxLines: 10,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(200),
                            ],
                            decoration: InputDecoration(
                              hintText: "Descrição *",
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.add_location),
                          title: TextFormField(
                            initialValue: morada,
                            validator: (value) {
                              _morada = value;
                              return null;
                            },
                            minLines: 1,
                            maxLines: 3,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(60),
                            ],
                            decoration: InputDecoration(
                              hintText: "Morada",
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }
            );
          },
        ),
        floatingActionButton:
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

                final now = DateTime.now();
                final date = DateFormat('yyyy/MM/dd – kk:mm').format(now);

                incidentes.alter(_titulo, _descricao, _morada, date, "Aberto", widget.indice);

                Navigator.pop(context);
                Navigator.pop(context);
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
    incidentes.dispose();
    super.dispose();
  }
}