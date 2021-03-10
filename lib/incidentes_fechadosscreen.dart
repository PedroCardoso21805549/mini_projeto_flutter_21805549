import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentes_fechadosscreen.dart';

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
    incidentesFechados.getAll();
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
          stream: incidentesFechados.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var titulo = snapshot.data[index].tituloIncidente;
                //var descricao = snapshot.data[index].descricaoIncidente;
                //var morada = snapshot.data[index].moradaIncidente;
                var date = snapshot.data[index].dataIncidente;
                //var estado = snapshot.data[index].estadoIncidente;
                var indice = index;
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