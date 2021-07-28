import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_mobile/models/Buyer.dart';

class ListBuyers extends StatefulWidget {
  ListBuyers({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  State<StatefulWidget> createState() => _ListBuyersState();
}

class _ListBuyersState extends State<ListBuyers> {
  @override
  Widget build(BuildContext context) {
    final buyers = http.get(Uri.parse("http://${widget.host}/buyers"));

    return Scaffold(
      appBar: AppBar(
        title: Text("List all buyers"),
      ),
      body: FutureBuilder<http.Response>(
        future: buyers,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "There was an error retrieving the list of buyers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            print(QueryBuyer.fromJson(jsonDecode(snapshot.data!.body))
                .buyers
                .length);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                children: QueryBuyer.fromJson(jsonDecode(snapshot.data!.body))
                    .buyers
                    .map((buyer) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      child: ListTile(
                        title: Row(children: [
                          Text(
                            "Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(buyer["name"])
                        ]),
                        subtitle: Row(children: [
                          Text(
                            "Age: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(buyer["age"].toString())
                        ]),
                        trailing: Icon(Icons.person),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
