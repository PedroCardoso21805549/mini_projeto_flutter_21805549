import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';

class MostraIncidenteFechadosScreen extends StatelessWidget{
  final incidentesfechados = IncidentesFechados();
  final int indice;

  MostraIncidenteFechadosScreen({Key key, this.indice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    incidentesfechados.getAll();
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (context, index) {
                if(indice == index){
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
      ),
    );
  }
}