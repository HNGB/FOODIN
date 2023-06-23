import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/blog.dart';

class BlogService {
  Future<List<Blog>> getBlogs() async {
    final response = await http
        .get(Uri.parse('https://foodiapi.azurewebsites.net/api/Blog'));

    if (response.statusCode == 200) {
      var blogsJson = jsonDecode(response.body) as List;
      List<Blog> c = blogsJson.map((blogJs) => Blog.fromJson(blogJs)).toList();
      return c;
    } else {
      throw Exception('Failed to load Blogs');
    }
  }

  Future<void> createPost(
      int userId, String? title, String blogContent, String? blogImage) async {
    const apiUrl = 'https://foodiapi.azurewebsites.net/api/Blog';

    final requestBody = jsonEncode({
      'userId': userId,
      'title': title,
      'blogContent': blogContent,
      'blogImage': blogImage,
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      print('Post created successfully');
    } else {
      print('Failed to create post. Error: ${response.statusCode}');
    }
  }
}
