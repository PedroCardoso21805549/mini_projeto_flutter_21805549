import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentes_fechadosscreen.dart';

class IncidentesFechadosScreen extends StatefulWidget {

  @override
  _IncidentesFechadosScreenState createState() => _IncidentesFechadosScreenState();
}

class _IncidentesFechadosScreenState extends State<IncidentesFechadosScreen>{
  final incidentes = Incidentes();

  @override
  Widget build(BuildContext context){
    incidentes.getAll();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Incidentes Fechados"),
        ),
        body: StreamBuilder(
          initialData: [],
          stream: incidentes.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var titulo = snapshot.data[index].tituloIncidente;
                  var date = snapshot.data[index].dataIncidente;
                  var estado = snapshot.data[index].estadoIncidente;
                  var indice = index;
                  if(estado == "Fechado") {
                    return Card(
                      child: ListTile(
                          title: Text(titulo),
                          subtitle: Text(date),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MostraIncidenteFechadosScreen(indice: indice)
                              ),
                            );
                          }
                      ),
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

  @override
  void dispose() {
    incidentes.dispose();
    super.dispose();
  }
}