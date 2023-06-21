import 'dart:io';

import 'package:flutter/material.dart';

import '../model/review.dart';
import '../service/review_service.dart';

class ReviewsScreen extends StatefulWidget {
  final int restaurantId;

  const ReviewsScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  ReviewService reviewService = ReviewService();

  List<Review> reviews = [];
  int reviewCount = 0;
  @override
  void initState() {
    super.initState();
    loadReview();
  }

  void loadReview() async {
    try {
      final reviews =
          await ReviewService().getReviewsByRestaurantId(widget.restaurantId);
      final reviewCount = reviews.length;
      setState(() {
        this.reviews = reviews.toList();
        this.reviewCount = reviewCount;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(),
                        const SizedBox(
                          height: 50,
                          child: CircleAvatar(
                            // Đặt avatar mặc định tại đây
                            backgroundColor:
                                Colors.blue, // Màu nền của avatar mặc định
                            child: Icon(
                              Icons.person,
                              color: Colors
                                  .white, // Màu biểu tượng của avatar mặc định
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Khoảng cách giữa avatar và tên
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.fullName,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                review.dateReview,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 211, 211, 211),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color:
                          Color.fromARGB(255, 206, 206, 206), //color of divider
                      height: 5, //height spacing of divider
                      thickness: 0.5, //thickness of divier line
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < review.ratingReview
                              ? Colors.yellow
                              : Colors.grey,
                          size: 35.0,
                        );
                      }),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      review.comment,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 118, 118, 118),
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            LikeButton(review: review),
                            const SizedBox(height: 4.0),
                            Text(review.helpful.toString()),
                          ],
                        ),
                        Column(
                          children: [
                            UnlikeButton(review: review),
                            const SizedBox(height: 4.0),
                            Text(review.unhelpful.toString()),
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
            widget.review.helpful++;
          } else {
            widget.review.unhelpful--;
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
            widget.review.unhelpful++;
          } else {
            widget.review.unhelpful--;
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
