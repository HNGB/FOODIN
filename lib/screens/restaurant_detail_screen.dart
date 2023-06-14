import 'dart:io';

import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
        centerTitle: true,
        title: const Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'District 9, Ho Chi Minh City',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Pizza Hut',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/pizzaHut.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewsScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(Icons.restaurant_menu,
                                      size: 45, color: Colors.white),
                                  SizedBox(height: 8),
                                  Text(
                                    'Menu',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotosScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.photo_library,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Photos',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InformationScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(Icons.info,
                                      size: 45, color: Colors.white),
                                  SizedBox(height: 8),
                                  Text(
                                    'Info',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 300, // Set the height for the reviews container
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      children: [
                        ExpansionPanelList(
                          elevation: 1,
                          expandedHeaderPadding: EdgeInsets.zero,
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return const ListTile(
                                  leading: Icon(Icons.reviews),
                                  title: Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              body: const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Reviewer Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Bình luận về nhà hàng',
                                      ),
                                    ),
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Reviewer Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Bình luận về nhà hàng',
                                      ),
                                    ),
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Reviewer Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Bình luận về nhà hàng',
                                      ),
                                    ),
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Reviewer Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Bình luận về nhà hàng',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteReviewScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Write a Review'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
                    offset: Offset(0, 3),
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
                        const Spacer(), // Thêm Spacer để tách title và hàng sao
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

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: const Center(
        child: Text('Menu của nhà hàng'),
      ),
    );
  }
}

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: const Center(
        child: Text('Ảnh của nhà hàng'),
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: const Center(
        child: Text('Thông tin về nhà hàng'),
      ),
    );
  }
}

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({Key? key});

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
            const Expanded(
              child: TextField(
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
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to post the review
              },
              child: const Text('Post Review'),
            ),
          ],
        ),
      ),
    );
  }
}
