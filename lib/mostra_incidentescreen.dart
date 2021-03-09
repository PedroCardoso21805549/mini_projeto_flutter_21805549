import 'package:flutter/material.dart';
import 'package:mini_projeto_flutter_21805549/data/object_incidente.dart';
import 'package:mini_projeto_flutter_21805549/data/datasource.dart';

class MostraIncidenteScreen extends StatelessWidget{
  final ObjectIncidente incidente;
  final _dataSource = DataSource.getInstance();

  MostraIncidenteScreen({Key key, this.incidente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detalhe Incidente"),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.title),
              title: Text("Título"),
              subtitle: Text(incidente.titulo),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text("Descrição"),
              subtitle: Text(incidente.descricao),
            ),
            ListTile(
              leading: Icon(Icons.add_location),
              title: Text("Morada"),
              subtitle: Text(incidente.morada),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Data"),
              subtitle: Text(incidente.data),
            ),
            ListTile(
              leading: Icon(Icons.assessment),
              title: Text("Estado"),
              subtitle: Text(incidente.estado),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "btnEdit",
                  onPressed: () {
                    final snackbar = SnackBar(
                      content: Text('O seu incidente foi editado com sucesso.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: (){},
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    FocusScope.of(context).unfocus();

                    Navigator.pop(context);
                    //Navigator.pop(context);
                  },
                  tooltip: 'Editar',
                  child: Icon(Icons.edit),
                ),
                FloatingActionButton(
                  heroTag: "btnDelete",
                  onPressed: () {
                    final snackbar = SnackBar(
                      content: Text('O incidente selecionado foi eliminado com sucesso.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: (){},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    FocusScope.of(context).unfocus();

                    for(var h=0; h<_dataSource.getAll().length; h++){
                      if(incidente.titulo == _dataSource.getAll()[h].titulo){
                        _dataSource.remove(h);
                      }
                    }

                    Navigator.pop(context);
                    //Navigator.pop(context);
                  },
                  tooltip: 'Apagar',
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
      ),
    );
  }
}