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

// ALERTA CON INPUT TEXT
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nuevo piloto'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    txtCompetidor = valueText;
                    listaCompetidores
                        .add(new Item(txtCompetidor, DateTime.now()));
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String txtCompetidor;
  String valueText;

  List<Item> listaCompetidores = List();

  ordenar(){
    
  }

/*
  List<Widget> _listar() {
    List<Widget> lista = new List();

    for (var i = 0; i < listaCompetidores.length; i++) {
      lista.add(new Card(
        child: new ListTile(
            title: Text(
          (i + 1).toString() +
              " - " +
              listaCompetidores[i].competidor +
              " - " +
              DateFormat('mm:ss.SSS').format(listaCompetidores[i].tiempo),
          style: new TextStyle(
              fontFamily: 'DS-Digital', fontSize: 45, color: Colors.red),
        )),
        color: Colors.black,
      ));
    }
    return lista;
  }
*/

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
