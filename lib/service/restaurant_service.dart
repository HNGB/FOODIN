import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/restaurant.dart';

class RestaurantService {
  Future<List<Restaurant>> getTrendingRestaurantsByDistrictId(
      int districtId) async {
    final apiUrl =
        'https://foodiapi.azurewebsites.net/api/Review/TrendingRestaurant/$districtId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final restaurantsJson = jsonDecode(response.body) as List;
      return restaurantsJson
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();
    } else {
      throw Exception('Failed to load trending restaurants');
    }
  }

  Future<List<Restaurant>> getRestaurantsByDistrictId(int districtId) async {
    final apiUrl =
        'https://foodiapi.azurewebsites.net/api/Restaurant/ByDistrict/$districtId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final restaurantsJson = jsonDecode(response.body) as List;
      List<Restaurant> res = restaurantsJson
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();
      return res;
    } else {
      throw Exception('Failed to load trending restaurants');
    }
  }
}
