import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../service/review_service.dart';

class WriteReviewScreen extends StatefulWidget {
  final int restaurantId;

  const WriteReviewScreen({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int _rating = 0;
  User? user;
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  ReviewService reviewService = ReviewService();
  @override
  void initState() {
    super.initState();
    getUserFromSharedPreferences();
  }

  void getUserFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User fetchedUser = User.fromJson(userMap);

        setState(() {
          user = fetchedUser;
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void sendReview() {
    final String title = titleController.text;
    final String comment = commentController.text;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
    } else if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a comment')),
      );
    } else {
      final data = {
        'restaurantId': widget.restaurantId,
        'userId': user?.userId,
        'ratingReview': _rating,
        'title': title,
        'image': null,
        'comment': comment,
      };
      reviewService.postData(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color blueColor = const Color.fromARGB(255, 64, 47, 180);
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text('Rate & Share'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review Title',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 68, 91)),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: TextField(
                      maxLines: null,
                      controller: titleController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 226, 226, 226))),
                        hintText: 'Enter the Title',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28.0,
                            color: Color.fromARGB(255, 222, 222, 222)),
                      ),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "What's Your Rate?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 68, 91)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      for (int i = 1; i <= 5; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating = i;
                            });
                          },
                          child: Icon(
                            Icons.star_rounded,
                            size: 50,
                            color: i <= _rating
                                ? const Color.fromARGB(
                                    255, 254, 173, 84) // Màu vàng
                                : const Color.fromARGB(
                                    255, 193, 193, 193), // Màu xám
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Review',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 68, 91)),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    child: TextField(
                      maxLines: null,
                      controller: commentController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 226, 226, 226))),
                        hintText: 'Write your review here...',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 208, 208, 208),
                            fontSize: 20),
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 100),
                      ),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upload Images',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 68, 91)),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 245, 245, 245),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: 48, // Kích thước biểu tượng
                        color: Colors.grey, // Màu biểu tượng
                      ),
                    ),
                  ),
                  const SizedBox(height: 46),
                  ElevatedButton(
                    onPressed: sendReview,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          blueColor), // Đổi màu nền thành màu xanh
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                    ),
                    child: const Text(
                      'Submit Your Review',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
