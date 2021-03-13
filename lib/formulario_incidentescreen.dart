import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:intl/intl.dart';

class FormularioIncidenteScreen extends StatefulWidget {
  @override
  _FormularioIncidenteScreenState createState() => _FormularioIncidenteScreenState();
}

class _FormularioIncidenteScreenState extends State<FormularioIncidenteScreen>{
  final _formKey = GlobalKey<FormState>();
  final _controllerTitulo = TextEditingController();
  final _controllerDescricao = TextEditingController();
  final _controllerMorada = TextEditingController();
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
          title: Text("Formulário Incidente"),
        ),
        body: StreamBuilder(
          initialData: [],
          stream: incidentes.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.title),
                      title: TextFormField(
                        controller: _controllerTitulo,
                        validator: (value) {
                          if(value.isEmpty){
                            return "Por favor preencha este campo";
                          }
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
                        controller: _controllerDescricao,
                        validator: (value) {
                          if(value.isEmpty){
                            return "Por favor preencha este campo";
                          }
                          if(value.length < 100){
                            return "A descrição deve conter entre 100 a 200 caracteres";
                          }
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
                        controller: _controllerMorada,
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
              ),
            );
          },
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

                incidentes.insert(_controllerTitulo.text, _controllerDescricao.text, _controllerMorada.text, date, "Aberto");

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
    _controllerTitulo.dispose();
    _controllerDescricao.dispose();
    _controllerMorada.dispose();
    super.dispose();
  }


}