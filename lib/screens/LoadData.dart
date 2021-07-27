import 'package:flutter/material.dart';

class LoadData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: const Text(
                            'Ingresar fecha',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.center,
                        ),
                        TextFormField(
                          controller: _dateController,
                          decoration: const InputDecoration(labelText: 'fecha'),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Ingresa la fecha';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
    );
  }

  /// Clean up the controller when the Widget is disposed
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
