import 'package:flutter/material.dart';

class GetBuyer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GetBuyerState();
}

class _GetBuyerState extends State<GetBuyer> {
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
                      'Enter the ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(labelText: 'ID'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter the ID';
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
