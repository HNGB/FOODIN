import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/vote.dart';

class VoteService {
  Future<List<Vote>> getVoteByUserId(int userId) async {
    final String apiUrl =
        'https://foodiapi.azurewebsites.net/api/Review/Vote/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Vote> votes =
          jsonData.map((json) => Vote.fromJson(json)).toList();
      return votes;
    } else {
      throw Exception(
          'Failed to get votes. Status code: ${response.statusCode}');
    }
  }

  Future<void> voteAReview(Map<String, dynamic> data) async {
    const url =
        'https://foodiapi.azurewebsites.net/api/Review/Vote'; // Thay thế bằng URL của API POST của bạn

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode(data);

    final response =
        await http.put(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
    } else {
      // Xử lý khi gọi API thất bại
      print('API POST thất bại');
    }
  }
}
