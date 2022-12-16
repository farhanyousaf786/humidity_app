import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper
{
  final String url ;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);
      int condition = decodeData['weather'][0]['id'];
      String cityName = decodeData['name'];
     var humidity = decodeData['main']['humidity'];

      return decodeData ;
    } else {
      print(response.statusCode);
    }
  }
}