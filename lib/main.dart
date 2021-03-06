import 'package:flutter/material.dart';
import 'package:restaurant_mobile/screens/Home.dart';
import 'package:restaurant_mobile/screens/SelectHost.dart';
import 'package:restaurant_mobile/utils/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var host = prefs.getString("host");
  var validHost = false;
  if (host != null) {
    validHost = await verifyHost(host);
  }
  runApp(MyApp(
    validHost: validHost,
    host: host,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.validHost, required this.host})
      : super(key: key);

  final bool validHost;
  final String? host;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: validHost
          ? Home(
              host: host!,
            )
          : SelectHost(),
    );
  }
}
