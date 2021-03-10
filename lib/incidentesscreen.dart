import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';
import 'package:mini_projeto_flutter_21805549/formulario_incidentescreen.dart';
import 'package:mini_projeto_flutter_21805549/mostra_incidentescreen.dart';

class IncidentesScreen extends StatefulWidget {
  final Incidentes incidentes;

  IncidentesScreen({this.incidentes});

  @override
  _IncidentesScreenState createState() => _IncidentesScreenState();
}

class _IncidentesScreenState extends State<IncidentesScreen>{
  final incidentes = Incidentes();
  final incidentesFechados = IncidentesFechados();
  final _random = Random();

  @override
  Widget build(BuildContext context){
    incidentes.getAll();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
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
                var descricao = snapshot.data[index].descricaoIncidente;
                var morada = snapshot.data[index].moradaIncidente;
                var date = snapshot.data[index].dataIncidente;
                var estado = snapshot.data[index].estadoIncidente;
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    background: Container(color: Colors.red),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd && estado == "Resolvido") {
                        incidentes.setEstado(index, "Fechado");
                        incidentesFechados.insert(titulo, descricao, morada, date, estado);
                        incidentes.remove(index);

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
                                MostraIncidenteScreen(indice: index)),
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

                        final tam = incidentes.getAll().length;
                        final lista = incidentes.getAllAsStringAsList();

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
                              if (dados[4] == "Aberto" && int.parse(dados[5]) == r) {
                                incidentes.setEstado(count, "Resolvido");
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
                        //Navigator.pop(context);
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