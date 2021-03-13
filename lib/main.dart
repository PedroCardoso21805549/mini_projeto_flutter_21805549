import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_projeto_flutter_21805549/incidentes_fechadosscreen.dart';
import 'package:mini_projeto_flutter_21805549/incidentesscreen.dart';
import 'package:mini_projeto_flutter_21805549/BLoC/incidentes.dart';

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
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(title: 'Municipio Resolve'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Image.asset('lib/assets/splashscreen.png'),
      ),
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

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormat('yyyy/MM/dd – kk:mm').format(now);
    incidentes.insert("teste1", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque eleifend mollis massa, sit amet at.", "teste1", date, "Aberto");
    incidentes.insert("teste2", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In laoreet erat et orci consectetur elementum. Nulla hendrerit augue in urna euismod, quis consequat nunc euismod. Integer vel neque molestie.", "", date, "Aberto");

    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: Image.asset(
                  'lib/assets/initialPage.jpg',
                ),
              ),
              SizedBox(
                width: 350.0,
                child: TypewriterAnimatedTextKit(
                  text: [
                    "O que pretende fazer hoje?",
                  ],
                  textStyle: TextStyle(
                      fontSize: 28.0,
                      fontFamily: "Agne"
                  ),
                  textAlign: TextAlign.start,
                  speed: Duration(milliseconds: 200),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60.0),
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text('Lista de Incidentes', style: TextStyle(fontSize: 24.0),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IncidentesScreen()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text('Incidentes Fechados', style: TextStyle(fontSize: 24.0),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IncidentesFechadosScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}
