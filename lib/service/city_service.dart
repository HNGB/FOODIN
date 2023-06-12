import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/City.dart';

class CityService {
  Future<List<City>> getCities() async {
    final response = await http
        .get(Uri.parse('https://foodiapi.azurewebsites.net/api/City'));

    if (response.statusCode == 200) {
      var citiesJson = jsonDecode(response.body) as List;
      List<City> c =
          citiesJson.map((cityJson) => City.fromJson(cityJson)).toList();
      return c;
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
