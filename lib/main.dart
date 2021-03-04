import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/incidentes_fechadosscreen.dart';
import 'package:mini_projeto_flutter_21805549/incidentesscreen.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes_fechados.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Municipio Resolve'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final incidentes = Incidentes();
  final incidentesFechados = IncidentesFechados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'lib/assets/initialPage.jpg',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50.0, top: 50.0),
              child: Text('O que pretende fazer hoje?', style: TextStyle(color: Colors.white, fontSize: 30.0),),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Text('Lista de Incidentes', style: TextStyle(fontSize: 24.0),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IncidentesScreen(
                      incidentes: incidentes,
                    )),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Text('Incidentes Fechados', style: TextStyle(fontSize: 24.0),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IncidentesFechadosScreen(
                      incidentesFechados: incidentesFechados,
                    )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resolveIncidente,
        tooltip: 'Resolve Incidente',
        child: Icon(Icons.assignment_turned_in),
      ),
    );
  }

  void _resolveIncidente() {
    setState(() {

    });
  }
}
