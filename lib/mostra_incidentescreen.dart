import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/editar_incidentescreen.dart';

class MostraIncidenteScreen extends StatefulWidget {
  final int indice;

  MostraIncidenteScreen({Key key, this.indice}) : super(key: key);

  @override
  _MostraIncidenteScreenState createState() => _MostraIncidenteScreenState();
}

class _MostraIncidenteScreenState extends State<MostraIncidenteScreen>{
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
          title: Text("Detalhe Incidente"),
        ),
        body: StreamBuilder(
          initialData: [],
          stream: incidentes.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                if(widget.indice == index){
                  var titulo = snapshot.data[index].tituloIncidente;
                  var descricao = snapshot.data[index].descricaoIncidente;
                  var morada = snapshot.data[index].moradaIncidente;
                  var date = snapshot.data[index].dataIncidente;
                  var estado = snapshot.data[index].estadoIncidente;

                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.title),
                        title: Text("Título"),
                        subtitle: Text(titulo),
                      ),
                      ListTile(
                        leading: Icon(Icons.description),
                        title: Text("Descrição"),
                        subtitle: Text(descricao),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_location),
                        title: Text("Morada"),
                        subtitle: Text(morada),
                      ),
                      ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text("Data"),
                        subtitle: Text(date),
                      ),
                      ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text("Estado"),
                        subtitle: Text(estado),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "btnEdit",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditarIncidenteScreen(indice: widget.indice)),
                    );
                  },
                  tooltip: 'Editar',
                  child: Icon(Icons.edit),
                ),
                FloatingActionButton(
                  heroTag: "btnDelete",
                  onPressed: () {
                    final snackbar = SnackBar(
                      content: Text('O incidente selecionado foi eliminado com sucesso.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    FocusScope.of(context).unfocus();

                    incidentes.remove(widget.indice);
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
    incidentes.dispose();
    super.dispose();
  }
}