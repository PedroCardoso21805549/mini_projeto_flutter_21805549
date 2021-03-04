import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';

class IncidentesScreen extends StatefulWidget {
  final Incidentes incidentes;

  IncidentesScreen({this.incidentes});

  @override
  _IncidentesScreenState createState() => _IncidentesScreenState();
}

class _IncidentesScreenState extends State<IncidentesScreen>{
  final incidentes = Incidentes();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Incidentes"),
        ),
        body: StreamBuilder(
          initialData: incidentes.getAll(),
          stream: incidentes.output,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: _editarIncidente,
                tooltip: 'Editar Incidente',
                child: Icon(Icons.assignment),
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: _abrirIncidente,
                tooltip: 'Abrir Incidente',
                child: Icon(Icons.add),
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

  void _abrirIncidente() {
    setState(() {

    });
  }

  void _editarIncidente() {
    setState(() {

    });
  }
}