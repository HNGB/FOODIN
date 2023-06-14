import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/district.dart';

class DistrictService {
  Future<List<District>> getDistrictsByCityId(int cityId) async {
    final response = await http.get(
        Uri.parse('https://foodiapi.azurewebsites.net/api/District/$cityId'));

    if (response.statusCode == 200) {
      var districtsJson = jsonDecode(response.body) as List;
      return districtsJson
          .map((districtJson) => District.fromJson(districtJson))
          .toList();
    } else {
      throw Exception('Failed to load districts');
    }
  }
}
