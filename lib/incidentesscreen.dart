import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/data/datasourceFechados.dart';
import 'package:mini_projeto_flutter_21805549/formulario_incidentescreen.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentescreen.dart';
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';


class IncidentesScreen extends StatefulWidget {
  final Incidentes incidentes;

  IncidentesScreen({this.incidentes});

  @override
  _IncidentesScreenState createState() => _IncidentesScreenState();
}

class _IncidentesScreenState extends State<IncidentesScreen>{
  final incidentes = Incidentes();
  final _dataSource = DataSource.getInstance();
  final _dataSourceFechados = DataSourceFechados.getInstance();
  final _random = Random();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Incidentes"),
        ),
        body: StreamBuilder(
          initialData: incidentes.getAllAsString(),
          stream: incidentes.output,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var dados = snapshot.data[index].split(";");
                var titulo = dados[0];
                var date = dados[3];
                var estado = dados[4];
                var indice = int.parse(dados[5]);
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    background: Container(color: Colors.red),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd && estado == "Resolvido") {
                        _dataSource.getAll()[indice].estado = "Fechado";
                        _dataSourceFechados.insert(_dataSource.getAll()[indice]);
                        _dataSource.remove(indice);

                        final snackbar = SnackBar(
                          content: Text('O seu incidente foi dado como fechado.'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        FocusScope.of(context).unfocus();

                        return true;
                      } else {
                        final snackbar = SnackBar(
                          content: Text('Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        FocusScope.of(context).unfocus();
                        return false;
                      }
                    },
                    child: Card(
                      child: ListTile(
                        tileColor: estado == "Resolvido" ? Colors.green : Colors.white,
                        title: Text(titulo),
                        subtitle: Text(date),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                MostraIncidenteScreen(incidente: _dataSource.getAll()[indice])),
                          );
                        },
                      ),
                    ),
                  );
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
                  onPressed: () {
                    final tam = _dataSource.getAllAsString().length;
                    final lista = _dataSource.getAllAsString();

                    if(tam == 0){
                      final snackbar = SnackBar(
                        content: Text('Não existem incidentes abertos para resolver.'),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: (){},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      FocusScope.of(context).unfocus();
                    } else {
                      int r = next(0, tam);
                      int count = 0;
                      bool cicle = true;
                      while (cicle == true) {
                        for (var i in lista) {
                          var dados = i.split(";");
                          if (dados[4] == "Aberto" &&
                              int.parse(dados[5]) == r) {
                            _dataSource.getAll()[count].estado = "Resolvido";
                            cicle = false;
                          }
                          count++;
                        }
                        r = next(0, tam);
                        count = 0;
                      }

                      final snackbar = SnackBar(
                        content: Text(
                            'Um dos seus incidentes foi dado como resolvido.'),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      FocusScope.of(context).unfocus();
                    }
                    Navigator.pop(context);
                  },
                  tooltip: 'Resolve Incidente',
                  child: Icon(Icons.assignment_turned_in),
                ),
                FloatingActionButton(
                  heroTag: "btnOpen",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormularioIncidente()),
                    );
                  },
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

  int next(int min, int max) => min + _random.nextInt(max - min);
}