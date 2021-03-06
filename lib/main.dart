import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:time_list/models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      home: MyHomePage(title: 'Time List'),
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
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _minController = TextEditingController();
  TextEditingController _segController = TextEditingController();
  TextEditingController _milController = TextEditingController();

// Alerta con input
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Nuevo Tiempo',
              style: TextStyle(fontSize: 25),
            )),
            insetPadding: EdgeInsets.symmetric(horizontal: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: TextStyle(fontSize: 20),
                  onChanged: (value) {
                    setState(() {
                      nombreText = value;
                    });
                  },
                  controller: _nombreController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^([a-zA-Z0-9]){1,3}")),
                  ],
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^([0-5][0-9]?)$")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            minText = value;
                          });
                        },
                        controller: _minController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "00"),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                      child: Center(
                        child: Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                               RegExp(r"^([0-5][0-9]?)$")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            segText = value;
                          });
                        },
                        controller: _segController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "00"),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                      child: Center(
                        child: Text(
                          ".",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^(\d{1,3})$")),
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            milText = value;
                          });
                        },
                        controller: _milController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "000"),
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              ButtonTheme(
                minWidth: 265,
                height: 40,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      txtNombre = nombreText;
                      txtMin = minText;
                      txtSeg = segText;
                      txtMil = milText;
                      listaCompetidores.add(new Item(
                          validarNombre(txtNombre),
                          DateTime.parse('2021-01-01 01:' +
                              validar2d(txtMin) +
                              ':' +
                              validar2d(txtSeg) +
                              '.' +
                              validar3d(txtMil))));
                      ordenar();
                      _nombreController.clear();
                      _minController.clear();
                      _segController.clear();
                      _milController.clear();
                      txtNombre = '';
                      txtMin = '';
                      txtSeg = '';
                      txtMil = '';
                      nombreText = '';
                      minText = '';
                      segText = '';
                      milText = '';
                      Navigator.pop(context);
                    });
                  },
                ),
              )
            ],
          );
        });
  }

  // variables pal input nombre de competidor
  String txtNombre;
  String nombreText;

  // variables pal input tiempo de competidor
  String txtMin;
  String minText;

  // variables pal input tiempo de competidor
  String txtSeg;
  String segText;

  // variables pal input tiempo de competidor
  String txtMil;
  String milText;

  // lista de objetos "Item" que es una clase propia
  List<Item> listaCompetidores = List();

  ordenar() {
    listaCompetidores.sort((a, b) => a.tiempo.millisecondsSinceEpoch
        .compareTo(b.tiempo.millisecondsSinceEpoch));
  }

  String validarNombre(String nombre) {
    String cadena = nombre;
    if (cadena != null) {
      if (cadena.length == 0)
        cadena = 'XXX';
      else if (cadena.length == 1)
        cadena = cadena + cadena[0] + cadena[0];
      else if (cadena.length == 2) cadena = cadena + cadena[1];
    } else
      cadena = 'XXX';

    return cadena;
  }

  String validar2d(String numero) {
    String cadena = numero;
    if (cadena != null) {
      if (cadena.length == 0)
        cadena = '00' + cadena;
      else if (cadena.length == 1) cadena = '0' + cadena;
    } else
      cadena = '00';

    return cadena;
  }

  String validar3d(String numero) {
    String cadena = numero;
    if (cadena != null) {
      if (cadena.length == 0)
        cadena = '000' + cadena;
      else if (cadena.length == 1)
        cadena = '00' + cadena;
      else if (cadena.length == 2) cadena = '0' + cadena;
    } else
      cadena = '000';

    return cadena;
  }

  _deleteAlert(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Si"),
      onPressed: () {
        setState(() {
          listaCompetidores.clear();
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar lista"),
      content: Text("??Realmente desea eliminar toda la lista?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // FrontEnd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => {_displayTextInputDialog(context)},
            child: Icon(
              Icons.add,
              size: 40,
            ),
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => {_deleteAlert(context)},
            child: Icon(
              Icons.delete,
              size: 40,
            ),
            backgroundColor: Colors.red,
          )
        ],
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
                  fontFamily: 'DS-Digital', color: Colors.red, fontSize: 40),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listaCompetidores.length,
              itemBuilder: (context, int index) {
                return new Dismissible(
                  key: UniqueKey(),
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
                          fontSize: 35,
                          color: Colors.red),
                    )),
                    color: Colors.black,
                  ),
                  onDismissed: (direction) {
                    listaCompetidores.removeAt(index);
                    setState(() {
                      ordenar();
                    });
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
