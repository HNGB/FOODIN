import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/food.dart';

class FoodService {
  static const String baseUrl = 'https://foodiapi.azurewebsites.net/api';

  Future<List<Food>> getFoodListByRestaurantId(int restaurantId) async {
    final url = Uri.parse('$baseUrl/Food/$restaurantId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData as List).map((item) => Food.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load food list');
    }
  }
}
