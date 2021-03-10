import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';

class MostraIncidenteFechadosScreen extends StatelessWidget{
  final incidentesfechados = IncidentesFechados();
  final int indice;

  MostraIncidenteFechadosScreen({Key key, this.indice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    incidentesfechados.getObject(indice);
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
          stream: incidentesfechados.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.title),
                  title: Text("Título"),
                  subtitle: Text(snapshot.data.tituloIncidente),
                ),
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text("Descrição"),
                  subtitle: Text(snapshot.data.descricaoIncidente),
                ),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Text("Morada"),
                  subtitle: Text(snapshot.data.moradaIncidente),
                ),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text("Data"),
                  subtitle: Text(snapshot.data.dataIncidente),
                ),
                ListTile(
                  leading: Icon(Icons.assessment),
                  title: Text("Estado"),
                  subtitle: Text(snapshot.data.estadoIncidente),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}