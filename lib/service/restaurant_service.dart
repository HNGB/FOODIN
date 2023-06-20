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

  Future<void> addToFavorite(int userId, int restaurantId) async {
    const apiUrl =
        'https://foodiapi.azurewebsites.net/api/Restaurant/FavoriteARes';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userId': userId,
      'restaurantId': restaurantId,
    });

    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Favorite restaurant added successfully');
    } else {
      throw Exception('Failed to add favorite restaurant');
    }
  }

  Future<List<Restaurant>> getFavoriteRestaurantsByUserId(int userId) async {
    final apiUrl =
        'https://foodiapi.azurewebsites.net/api/Restaurant/Favorite/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final restaurantsJson = jsonDecode(response.body) as List;
      return restaurantsJson
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();
    } else {
      throw Exception('Failed to load favorite restaurants');
    }
  }

  // Các phương thức API khác...

  Future<Restaurant> getRestaurantById(int restaurantId) async {
    final apiUrl =
        'https://foodiapi.azurewebsites.net/api/Restaurant/$restaurantId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final restaurantJson = jsonDecode(response.body);
      return Restaurant.fromJson(restaurantJson);
    } else {
      throw Exception('Failed to load this restaurant');
    }
  }
}
