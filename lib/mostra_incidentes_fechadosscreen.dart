import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';

class MostraIncidenteFechadosScreen extends StatelessWidget{
  final ObjectIncidente incidente;

  MostraIncidenteFechadosScreen({Key key, this.incidente}) : super(key: key);

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
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.title),
              title: Text("Título"),
              subtitle: Text(incidente.titulo),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text("Descrição"),
              subtitle: Text(incidente.descricao),
            ),
            ListTile(
              leading: Icon(Icons.add_location),
              title: Text("Morada"),
              subtitle: Text(incidente.morada),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Data"),
              subtitle: Text(incidente.data),
            ),
            ListTile(
              leading: Icon(Icons.assessment),
              title: Text("Estado"),
              subtitle: Text(incidente.estado),
            ),
          ],
        ),
      ),
    );
  }
}