import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

Future<bool> loadData(DateTime date) async {
  String? res;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var host = prefs.getString("host");
  try {
    var r = await http.get(Uri.parse("http://$host/load/${date.millisecondsSinceEpoch~/1000}"));
    print("http://$host/${date.millisecondsSinceEpoch~/1000}");
    res = r.body;
    print(res);
  } on Exception catch (e) {
    print(e);
  }
  return res!.contains("Success");
}