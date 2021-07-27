import 'package:http/http.dart' as http;

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