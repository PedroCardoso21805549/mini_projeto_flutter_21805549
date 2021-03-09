import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';
import 'package:mini_projeto_flutter_21805549/data/datasourceFechados.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentes_fechadosscreen.dart';

class IncidentesFechadosScreen extends StatefulWidget {
  final IncidentesFechados incidentesFechados;

  IncidentesFechadosScreen({this.incidentesFechados});

  @override
  _IncidentesFechadosScreenState createState() => _IncidentesFechadosScreenState();
}

class _IncidentesFechadosScreenState extends State<IncidentesFechadosScreen>{
  final incidentesFechados = IncidentesFechados();
  final _dataSource = DataSourceFechados.getInstance();

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
          initialData: incidentesFechados.getAllAsString(),
          stream: incidentesFechados.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var dados = snapshot.data[index].split(";");
                var titulo = dados[0];
                var date = dados[3];
                var indice = int.parse(dados[5]);
                return Card(
                  child: ListTile(
                    title: Text(titulo),
                    subtitle: Text(date),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            MostraIncidenteFechadosScreen(incidente: _dataSource.getAll()[indice])),
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