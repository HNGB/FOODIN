import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/review.dart';

class ReviewService {
  Future<List<Review>> getReviewsByRestaurantId(int restaurantId) async {
    final String apiUrl =
        'https://foodiapi.azurewebsites.net/api/Review/$restaurantId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Review> reviews =
          data.map((review) => Review.fromJson(review)).toList();
      return reviews;
    } else {
      throw Exception(
          'Failed to get reviews. Status code: ${response.statusCode}');
    }
  }
}
