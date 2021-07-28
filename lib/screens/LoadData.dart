import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_mobile/utils/network.dart';

class LoadData extends StatefulWidget {
  LoadData({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  State<StatefulWidget> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  var _selectedDate = DateTime.now();
  var _result;
  var _sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Data"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: const Text(
                      'Select a date to load the data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "Current date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${_selectedDate.toLocal()}".split(' ')[0]),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Select date'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.all(10)),
                            onPressed: () {
                              loadData(widget.host, _selectedDate)
                                  .then((value) {
                                setState(() {
                                  _result = value;
                                  _sent = false;
                                });
                              });
                              setState(() {
                                _sent = true;
                              });
                            },
                            child: Text("Load Data")),
                      ),
                      _sent == true
                          ? CircularProgressIndicator()
                          : _result == null
                              ? Container()
                              : _result
                                  ? Icon(Icons.check_circle_outline,
                                      size: 50, color: Colors.green)
                                  : Icon(Icons.error_outline,
                                      size: 50, color: Colors.red)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        _selectedDate = picked;
      });
  }
}
