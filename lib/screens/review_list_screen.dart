import 'dart:io';

import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int index) {
          final review = reviews[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.title,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < review.rating
                                  ? Colors.yellow
                                  : Colors.grey,
                              size: 18.0,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      review.description,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LikeButton(review: review),
                            const SizedBox(width: 4.0),
                            Text(review.likes.toString()),
                            const SizedBox(width: 8.0),
                            UnlikeButton(review: review),
                            const SizedBox(width: 4.0),
                            Text(review.unlikes.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final Review review;

  const LikeButton({required this.review});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            widget.review.likes++;
          } else {
            widget.review.likes--;
          }
        });
      },
      child: Icon(
        Icons.thumb_up,
        color: isLiked ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class UnlikeButton extends StatefulWidget {
  final Review review;

  const UnlikeButton({required this.review});

  @override
  _UnlikeButtonState createState() => _UnlikeButtonState();
}

class _UnlikeButtonState extends State<UnlikeButton> {
  bool isUnliked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isUnliked = !isUnliked;
          if (isUnliked) {
            widget.review.unlikes++;
          } else {
            widget.review.unlikes--;
          }
        });
      },
      child: Icon(
        Icons.thumb_down,
        color: isUnliked ? Colors.red : Colors.grey,
      ),
    );
  }
}

class Review {
  String title;
  String description;
  int likes;
  int unlikes;
  int rating;

  Review({
    required this.title,
    required this.description,
    this.likes = 0,
    this.unlikes = 0,
    this.rating = 0,
  });
}

final List<Review> reviews = [
  Review(
    title: 'Nguyen Tan Duy',
    description:
        'I had a wonderful experience with their customer service team. They were very responsive and helpful in resolving my issue. The representative was polite and patient, ensuring that all my questions were answered. I highly recommend their customer service.',
    likes: 25,
    unlikes: 1,
    rating: 5,
  ),
  Review(
    title: 'Nguyen Duy',
    description: 'This app is amazing! It has all the features I need.',
    likes: 10,
    unlikes: 2,
    rating: 4,
  ),
  Review(
    title: 'Duy Nguyen',
    description: 'The app crashes sometimes and the UI could be better.',
    likes: 5,
    unlikes: 8,
    rating: 3,
  ),
  // Add more reviews here
];
