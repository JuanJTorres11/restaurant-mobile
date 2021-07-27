import 'package:flutter/material.dart';

class ListBuyers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListBuyersState();
}

class _ListBuyersState extends State<ListBuyers> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: const Text(
                            'Lista Compradores',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ),
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
