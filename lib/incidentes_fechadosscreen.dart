import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';

class IncidentesFechadosScreen extends StatefulWidget {
  final IncidentesFechados incidentesFechados;

  IncidentesFechadosScreen({this.incidentesFechados});

  @override
  _IncidentesFechadosScreenState createState() => _IncidentesFechadosScreenState();
}

class _IncidentesFechadosScreenState extends State<IncidentesFechadosScreen>{
  final incidentesFechados = IncidentesFechados();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Incidentes Fechados"),
        ),
        body: StreamBuilder(
          initialData: incidentesFechados.getAll(),
          stream: incidentesFechados.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${snapshot.data[index]}"),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    incidentesFechados.dispose();
    super.dispose();
  }
}