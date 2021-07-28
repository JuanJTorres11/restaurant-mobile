import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_mobile/models/Buyer.dart';

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

Future<bool> loadData(String host, DateTime date) async {
  String? res;
  try {
    var r = await http.get(
        Uri.parse("http://$host/load/${date.millisecondsSinceEpoch ~/ 1000}"));
    res = r.body;
  } on Exception catch (e) {
    print(e);
  }
  return res!.contains("Success");
}

Future<dynamic> getBuyerData(String host, String id) async {
  var res;
  try {
    var r = await http.get(Uri.parse("http://$host/buyers/$id"));
    res = jsonDecode(r.body);
  } on Exception catch (e) {
    print(e);
  }
  return res;
}
