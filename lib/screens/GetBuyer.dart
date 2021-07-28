import 'package:flutter/material.dart';
import 'package:restaurant_mobile/models/Buyer.dart';
import 'package:restaurant_mobile/utils/network.dart';

class GetBuyer extends StatefulWidget {
  GetBuyer({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  State<StatefulWidget> createState() => _GetBuyerState();
}

class _GetBuyerState extends State<GetBuyer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  bool _sent = false;
  var _buyerQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search a Buyer"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _idController,
                            decoration: const InputDecoration(labelText: 'ID'),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter the ID';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.all(10)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                getBuyerData(widget.host, _idController.text)
                                    .then((value) {
                                  setState(() {
                                    _buyerQuery = value;
                                  });
                                });
                                setState(() {
                                  _sent = true;
                                });
                              }
                            },
                            child: Text("Send")),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ),
          _sent ? _showBuyerData() : Container(),
        ],
      ),
    );
  }

  /// Clean up the controller when the Widget is disposed
  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Widget _showBuyerData() {
    return _buyerQuery == null
        ? Center(child: CircularProgressIndicator())
        : Expanded(
          child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Buyer Data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      ),
                      ListTile(
                        title: Row(children: [
                          Text(
                            "Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_buyerQuery!['Buyer']['getBuyer']['name'])
                        ]),
                        subtitle: Row(children: [
                          Text(
                            "Age: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              _buyerQuery!['Buyer']['getBuyer']["age"].toString())
                        ]),
                        trailing: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: const Text(
                          'Purchase History',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        height: 400,
                        child: ListView(
                          children: _buyerQuery!['Buyer']['getBuyer']
                                  ['transactions']
                              .map<Widget>((transactions) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: transactions['products'].map<Widget>((product) {
                                      return Card(
                                        child: ListTile(
                                          title: Row(
                                                children: [
                                              Text(
                                                "Name: ",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Expanded(child: Text(product["name"]))
                                            ]),
                                          subtitle: Row(children: [
                                            Text(
                                              "Price: ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text("\$${product["price"]/100} USD")
                                          ]),
                                          trailing: Icon(Icons.fastfood),
                                        ),
                                      );
                                  }).toList(),
                                  ),
                                ),
                              )
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: const Text(
                          'Other Buyers in your location',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buyerQuery!['Other_Buyers']
                              .map<Widget>((buyer) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: 170,
                                child: Card(
                                  child: ListTile(
                                    title:
                                    Text(
                                      buyer,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.person),
                                  ),
                                ),
                              )
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: const Text(
                          'Recommended Products',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buyerQuery!['Recommended_Products']
                              .map<Widget>((buyers) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: 170,
                                  child: Card(
                                    child: ListTile(
                                      title:
                                      Text(
                                        buyers,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Icon(Icons.fastfood),
                                    ),
                                  ),
                                )
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        );
  }
}
