import 'package:flutter/material.dart';
import 'package:restaurant_mobile/screens/GetBuyer.dart';
import 'package:restaurant_mobile/screens/ListBuyers.dart';
import 'package:restaurant_mobile/screens/LoadData.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => LoadData()),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Load data",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.update,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => ListBuyers(
                          host: host,
                        )),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List all buyers",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.people_alt_rounded,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute<void>(builder: (_) => GetBuyer())),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search a Buyer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.person,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
