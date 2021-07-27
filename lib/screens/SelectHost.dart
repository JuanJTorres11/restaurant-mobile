import 'package:flutter/material.dart';
import 'package:restaurant_mobile/screens/Home.dart';
import 'package:restaurant_mobile/utils/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectHost extends StatefulWidget {
  @override
  _SelectHostState createState() => _SelectHostState();
}

class _SelectHostState extends State<SelectHost> {
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
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(builder: (_) => Home()),
                                      );
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
}