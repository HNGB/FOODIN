import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

  Future<void> postData(BuildContext context, Map<String, dynamic> data) async {
    const url =
        'https://foodiapi.azurewebsites.net/api/Review'; // Thay thế bằng URL của API POST của bạn

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode(data);

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review posted')),
      );
      Timer(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      // Xử lý khi gọi API thất bại
      print('API POST thất bại');
    }
  }
}
