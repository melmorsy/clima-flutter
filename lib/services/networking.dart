import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper
{
  final Uri uri;

  NetworkHelper(this.uri);

  Future getData() async {
    http.Response response = await http.get(uri);

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}