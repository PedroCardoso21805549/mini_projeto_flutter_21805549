import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';

class MostraIncidenteFechadosScreen extends StatefulWidget {
  final int indice;

  MostraIncidenteFechadosScreen({Key key, this.indice}) : super(key: key);

  @override
  _MostraIncidenteFechadosScreenState createState() => _MostraIncidenteFechadosScreenState();
}

class _MostraIncidenteFechadosScreenState extends State<MostraIncidenteFechadosScreen>{
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
                  if(estado != "Aberto") {
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
                  }
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

  @override
  void dispose() {
    incidentes.dispose();
    super.dispose();
  }
}