import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _host = false;
  var _showMessage = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido"),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _hostController,
                          decoration: const InputDecoration(
                              labelText: 'Ingresa la url y puerto de la API',
                              prefixText: "http://",
                              focusColor: Colors.grey),
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'Ingresa la url y puerto';
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: double.infinity),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context)
                                        .primaryColor, // background
                                    onPrimary: Colors.black, // foreground
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.all(16)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var con = await verifyHost(_hostController.text);
                                    if (con){
                                      setState(() {
                                        _showMessage = false;
                                      });
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("host", _hostController.text);

                                    }
                                    else {
                                      setState(() {
                                        _showMessage = true;
                                      });
                                    }
                                  }
                                },
                                child: Text("Enviar")),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            _showMessage == false
                                ? ''
                                : "La dirección indicada es inválida",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ])))),
    );
  }

  Future<bool> verifyHost(String url) async {
    String? res;
    try {
      var r = await http.get(Uri.parse("http://" + url));
      res = r.body;
    } on Exception catch (e) {
      print(e);
    }
    return res == "hello world";
  }
}
