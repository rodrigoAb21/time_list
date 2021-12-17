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
                      nombreTxt = value;
                    });
                  },
                  controller: _nombreController,
                  keyboardType: TextInputType.text,
                  maxLength: 3,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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
                            minText = value;
                          });
                        },
                        controller: _minController,
//                  keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "00"
                        ),
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
                              RegExp(r"^(\d{1,2})$")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            segText = value;
                          });
                        },
                        controller: _segController,
//                  keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "00"
                        ),
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
//                  keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          setState(() {
                            milText = value;
                          });
                        },
                        controller: _milController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "000"
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK', style: TextStyle(fontSize: 20),),
                onPressed: () {
                  setState(() {
                    txtNombre = nombreTxt;
                    //txtDate = dateText;
                    txtMin = minText;
                    txtSeg = segText;
                    txtMil = milText;
                    listaCompetidores.add(new Item(
                        txtNombre,
                        DateTime.parse('2021-01-01 01:' +
                            validarMin(txtMin) +
                            ':' +
                            validarSeg(txtSeg) +
                            '.' +
                            validarMil(txtMil))));
                    ordenar();
                    _nombreController.clear();
                    _minController.clear();
                    _segController.clear();
                    _milController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  // variables pal input nombre de competidor
  String txtNombre;
  String nombreTxt;

  // variables pal input tiempo de competidor
  //String txtDate;
  //String dateText;

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

  String validarMin(String minutos) {
    String cadena = minutos;
    if (cadena.length == 1) {
      cadena = '0' + cadena;
    }
    return cadena;
  }

  String validarSeg(String segundos) {
    String cadena = segundos;
    if (cadena.length == 1) {
      cadena = '0' + cadena;
    }
    return cadena;
  }

  String validarMil(String milesima) {
    String cadena = milesima;
    if (cadena.length == 1) {
      cadena = '00' + cadena;
    } else {
      if (cadena.length == 2) {
        cadena = '0' + cadena;
      }
    }
    return cadena;
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
