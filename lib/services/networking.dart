import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static const String urlSample =
      'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22';

  NetworkHelper();

  Future getData(String urlAsString) async {
/*
    var urlBetter = Uri.https(
        'samples.openweathermap.org', 'data/2.5/weather', {
      'lat': '35',
      'lon': '139',
      'appid': 'b6907d289e10d714a6e88b30761fae22'
    });
*/
    Uri url = Uri.parse(urlAsString);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(
          'statusCode=${response.statusCode}\nresponse.body=${response.body}');
    }
  }
}
