import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_list/models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      home: MyHomePage(title: 'Alert Dialog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

// Alerta con input
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Nuevo Tiempo')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
              onChanged: (value) {
                setState(() {
                  competidorText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)),
            ), SizedBox(height: 20.0,)
            ,TextField(
              onChanged: (value) {
                setState(() {
                  dateText = value;
                });
              },
              controller: _textFieldController2,
              decoration: InputDecoration(labelText: "Tiempo",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer)),
            )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    txtCompetidor = competidorText;
                    txtDate = dateText;
                    listaCompetidores
                        .add(new Item(txtCompetidor, DateTime.parse('2021-01-01 01:'+ txtDate)));
                        ordenar();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
  
  // variables pal input nombre de competidor
  String txtCompetidor;
  String competidorText;

  // variables pal input tiempo de competidor
  String txtDate;
  String dateText;

  // lista de objetos "Item" que es una clase propia
  List<Item> listaCompetidores = List();

  ordenar(){
        listaCompetidores.sort((a,b) => 
          a.tiempo.millisecondsSinceEpoch.compareTo(b.tiempo.millisecondsSinceEpoch)
        );
  }

  // FrontEnd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_displayTextInputDialog(context)},
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              "TIME LIST",
              style: TextStyle(
                  fontFamily: 'DS-Digital', color: Colors.red, fontSize: 50),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listaCompetidores.length,
              itemBuilder: (context, int index) {
                return new Dismissible(
                  key: new Key(listaCompetidores[index].tiempo.toString()),
                  child: new Card(
                    child: new ListTile(
                        title: Text(
                      (index + 1).toString() +
                          " - " +
                          listaCompetidores[index].competidor +
                          " - " +
                          DateFormat('mm:ss.SSS')
                              .format(listaCompetidores[index].tiempo),
                      style: new TextStyle(
                          fontFamily: 'DS-Digital',
                          fontSize: 45,
                          color: Colors.red),
                    )),
                    color: Colors.black,
                  ),
                  onDismissed: (direction) {
                    listaCompetidores.removeAt(index);
                  setState(() {
                    ordenar();
                  });
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: new Text("Eliminando")));
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
