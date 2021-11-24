import 'package:flutter/material.dart';

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
                    codeDialog = valueText;
                    competidores.add(codeDialog);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog;
  String valueText;

  List<String> competidores = List();

  List<Widget> _listar() {
    List<Widget> lista = new List();
    competidores.forEach((element) {
      lista.add(new Card(
        child: new ListTile(
            title: Text(
          element,
          style: new TextStyle(
              fontFamily: 'DS-Digital', fontSize: 55, color: Colors.red),
        )),
        color: Colors.black,
      ));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_displayTextInputDialog(context)},
        child: Icon(Icons.add, size: 40,),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView(children: _listar()),
      ),
    );
  }
}
