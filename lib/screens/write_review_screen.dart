import 'dart:io';

import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({Key? key}) : super(key: key);

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  TextEditingController reviewController = TextEditingController();
  int rating = 0;

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starColor = index < rating ? Colors.yellow : Colors.grey;
        return GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1;
            });
          },
          child: Icon(
            Icons.star,
            color: starColor,
            size: 30,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: reviewController,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Write your review',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add logic to handle image upload
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Upload Image'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(child: buildStarRating()),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final reviewText = reviewController.text.trim();
                if (reviewText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your review'),
                    ),
                  );
                  return;
                }
                if (rating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a rating'),
                    ),
                  );
                  return;
                }
              },
              child: const Text('Post Review'),
            ),
          ],
        ),
      ),
    );
  }
}
