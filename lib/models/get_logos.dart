import 'package:http/http.dart' as http;
import 'dart:convert';

import 'const_data.dart';


/// This Class contains a function that gets the Team Logos
/// The NHL API doesn't seem to return any urls

class LogosAPI{
  getLogos(String teamUrl) async {
    final response = await http.get(
        Uri.parse('https://besticon-demo.herokuapp.com/allicons.json?url=$teamUrl}')
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['icons'].isNotEmpty ?
      data['icons'][0]['url'] : ConstData().nhlLogo;
    }
    /// In case we were unable to retrieve the Logo, we set it to the NHL one
    else {
      return ConstData().nhlLogo;
    }
  }
}