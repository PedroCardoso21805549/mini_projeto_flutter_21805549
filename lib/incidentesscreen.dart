import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';
import 'package:mini_projeto_flutter_21805549/formulario_incidentescreen.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentes_fechadosscreen.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentescreen.dart';

class IncidentesScreen extends StatefulWidget {

  @override
  _IncidentesScreenState createState() => _IncidentesScreenState();
}

class _IncidentesScreenState extends State<IncidentesScreen>{
  final incidentes = Incidentes();
  //final incidentesResolvidos = Incidentes();
  final _random = Random();
  final datasource = DataSource.getInstance();

  @override
  Widget build(BuildContext context){
    incidentes.getAll();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        backgroundColor: Colors.white30,
        appBar: AppBar(
          title: Text("Lista de Incidentes"),
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
                if(estado=="Resolvido" || estado=="Aberto") {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(color: Colors.red),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd && estado == "Resolvido") {
                          incidentes.setEstado(index, "Fechado");

                          final snackbar = SnackBar(
                            content: Text(
                                'O seu incidente foi dado como fechado.'),
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
                            content: Text(
                                'Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.'),
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
                      child: ListTile(
                        leading: Icon(Icons.zoom_in_outlined),
                        tileColor: estado == "Resolvido" ? Colors.green : Colors.white,
                        title: Text(titulo),
                        subtitle: Text(date),
                        onTap: () {
                          if (estado == "Aberto") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MostraIncidenteScreen(indice: index)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MostraIncidenteFechadosScreen(indice: index)),
                            );
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            /*incidentesResolvidos.getAll();
                            StreamBuilder(
                              initialData: [],
                              stream: incidentesResolvidos.output,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                final tam = snapshot.data.length;
                                final lista = incidentesResolvidos.getAllAsStringAsList();*/

                                final tam = datasource.getAll().length;
                                final lista = datasource.getAllAsString();
                                var porResolver = 0;

                                for(var l in lista){
                                  var dados = l.split(";");
                                  if(dados[4] == "Aberto"){
                                    porResolver = 1;
                                  }
                                }

                                if (tam == 0 || porResolver == 0) {
                                  final snackbar = SnackBar(
                                    content: Text('Não existem incidentes para resolver.'),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbar);
                                  FocusScope.of(context).unfocus();
                                } else {
                                  int r = next(0, tam);
                                  int count = 0;
                                  int countResolvidos = 0;
                                  bool cicle = true;
                                  while (cicle == true) {
                                    for (var i in lista) {
                                      var dados = i.split(";");
                                      if (dados[4] == "Aberto" && int.parse(dados[5]) == r) {
                                        //incidentesResolvidos.setEstado(count, "Resolvido");
                                        incidentes.setEstado(count, "Resolvido");
                                        cicle = false;
                                      }
                                      if(dados[4] == "Resolvido"){
                                        countResolvidos++;
                                      }
                                      if(countResolvidos == tam){
                                        cicle = false;
                                      }
                                      count++;
                                    }
                                    r = next(0, tam);
                                    count = 0;
                                  }

                                  final snackbar = SnackBar(
                                    content: Text('Um dos seus incidentes foi dado como resolvido.'),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  FocusScope.of(context).unfocus();
                                }
                              /*},
                            );*/
                            Navigator.pop(context);
                          },
                          tooltip: 'Resolve Incidente',
                          child: Icon(Icons.assignment_turned_in),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: "btnOpen",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormularioIncidenteScreen()),
                          );
                        },
                        tooltip: 'Abrir Incidente',
                        child: Icon(Icons.add),
                      ),
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
    //incidentesResolvidos.dispose();
    super.dispose();
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}