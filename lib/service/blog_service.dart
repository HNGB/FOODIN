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
}
