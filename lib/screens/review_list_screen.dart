import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/review.dart';
import '../model/user.dart';
import '../model/vote.dart';
import '../service/review_service.dart';
import '../service/vote_service.dart';

class ReviewsScreen extends StatefulWidget {
  final int restaurantId;

  const ReviewsScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  ReviewService reviewService = ReviewService();
  VoteService voteService = VoteService();

  User? user;
  List<Vote> votes = [];
  List<Review> reviews = [];
  List<bool> isExpandedList = [];
  List<int> likedReviews = [];
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();
    getUserFromSharedPreferences();
    loadReview();
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
          loadVote();
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void loadReview() async {
    try {
      final reviews =
          await reviewService.getReviewsByRestaurantId(widget.restaurantId);
      final reviewCount = reviews.length;

      // Initialize expanded state for each review
      final initialExpandedState = List<bool>.filled(reviewCount, false);

      setState(() {
        this.reviews = reviews.toList();
        this.reviewCount = reviewCount;
        isExpandedList = initialExpandedState;
      });
    } catch (e) {
      print('Error loading reviews: $e');
      // Handle error, show error message to the user, etc.
    }
  }

  void loadVote() async {
    try {
      final votes = await voteService.getVoteByUserId(user!.userId);
      setState(() {
        this.votes = votes.toList();
      });
    } catch (e) {
      print('Error loading votes: $e');
      // Handle error, show error message to the user, etc.
    }
  }

  void toggleLike(int reviewId) {
    final index = reviews.indexWhere((review) => review.reviewId == reviewId);

    if (index != -1) {
      setState(() {
        if (likedReviews.contains(reviewId)) {
          reviews[index].helpful -= 1;
          likedReviews.remove(reviewId);
        } else {
          if (hasLikedReview(reviewId)) {
            reviews[index].helpful -= 1;
            likedReviews.remove(reviewId);
          } else {
            reviews[index].helpful += 1;
            likedReviews.add(reviewId);
          }
        }
      });

      final data = {
        "reviewId": reviewId,
        "userId": user?.userId,
      };
      voteService.voteAReview(data);
    }
  }

  bool hasLikedReview(int reviewId) {
    return votes.any((vote) => vote.reviewId == reviewId);
  }

  void _shareReview(Review review) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
                title: const Text('Facebook'),
                onTap: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại chia sẻ

                  final textToShare = '${review.title}\n${review.comment}';
                  final facebookUrl = Uri.parse(
                      'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(textToShare)}');
                  _launchUrl(facebookUrl);
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.lightBlueAccent,
                ),
                title: const Text('Twitter'),
                onTap: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại chia sẻ

                  final textToShare = '${review.title}\n${review.comment}';
                  final twitterUrl = Uri.parse(
                      'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(textToShare)}');
                  _launchUrl(twitterUrl);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await canLaunchUrl(url);
    } else {
      print('Không thể mở URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color blueColor = const Color.fromARGB(255, 64, 47, 180);
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text('Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int index) {
          final review = reviews[index];
          final isExpanded =
              isExpandedList[index]; // Get expanded state for current review

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
                              color: Colors.white,
                              size: 30, // Màu biểu tượng của avatar mặc định
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
                        const Spacer(), // Hoặc Expanded()
                        const Icon(
                          Icons.more_horiz,
                          size: 25,
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
                    if (review.title != null && review.title!.isNotEmpty)
                      Center(
                        child: Text(
                          review.title.toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 36, 53, 83),
                          ),
                        ),
                      ),
                    if (review.title != null && review.title!.isNotEmpty)
                      const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star_rounded,
                          color: index < review.ratingReview
                              ? const Color.fromARGB(255, 254, 173, 84)
                              : const Color.fromARGB(255, 199, 199, 199),
                          size: 37.0,
                        );
                      }),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      isExpanded || review.comment.length <= 100
                          ? review.comment
                          : '${review.comment.substring(0, 100)}...',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 108, 108, 108),
                        fontSize: 17.0,
                      ),
                    ),
                    if (review.comment.length > 100)
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpandedList[index] = !isExpanded;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              isExpanded ? 'See less' : 'See more',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 64, 47, 180),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: const Color.fromARGB(255, 64, 47, 180),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up_alt_rounded,
                                color: likedReviews.contains(review.reviewId) ||
                                        hasLikedReview(review.reviewId)
                                    ? const Color.fromARGB(255, 0, 183, 255)
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                toggleLike(review.reviewId);
                                setState(
                                    () {}); // Force a rebuild of the IconButton to update its color
                              },
                            ),
                            const SizedBox(width: 2.0),
                            Text(review.helpful.toString()),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.shareFromSquare,
                            color: Colors.grey,
                            size: 25,
                          ),
                          onPressed: () {
                            _shareReview(review);
                          },
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
