import 'dart:io';

import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        Text(
                          'District 9, Ho Chi Minh City',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
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
                        spreadRadius: 2,
                        blurRadius: 5,
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
                                  Icon(Icons.star, size: 45),
                                  SizedBox(height: 8),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
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
                                  Icon(Icons.restaurant_menu, size: 45),
                                  SizedBox(height: 8),
                                  Text(
                                    'Menu',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
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
                                  Icon(Icons.photo_library, size: 45),
                                  SizedBox(height: 8),
                                  Text(
                                    'Photos',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
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
                                  Icon(Icons.info, size: 45),
                                  SizedBox(height: 8),
                                  Text(
                                    'Info',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
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
                        body: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: const [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns the children at the beginning and end
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Reviewer Name', // Replace with the actual reviewer's name
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
                                          size:
                                              18), // Sample star icon, replace with actual star rating
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  'Bình luận về nhà hàng'), // Replace with the actual comment
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns the children at the beginning and end
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Reviewer Name', // Replace with the actual reviewer's name
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
                                          size:
                                              18), // Sample star icon, replace with actual star rating
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  'Bình luận về nhà hàng'), // Replace with the actual comment
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns the children at the beginning and end
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Reviewer Name', // Replace with the actual reviewer's name
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
                                          size:
                                              18), // Sample star icon, replace with actual star rating
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  'Bình luận về nhà hàng'), // Replace with the actual comment
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns the children at the beginning and end
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Reviewer Name', // Replace with the actual reviewer's name
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
                                          size:
                                              18), // Sample star icon, replace with actual star rating
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  'Bình luận về nhà hàng'), // Replace with the actual comment
                            ),
                          ],
                        ),
                        isExpanded: true, // Expand the panel by default
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  16.0, 0, 16.0, 8.0), // Adjust the vertical padding as needed
              child: SizedBox(
                height: 40, // Adjust the height as needed
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold), // Adjust the font size as needed
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
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Đánh giá 1'),
            subtitle: Text('Bình luận về nhà hàng'),
          ),
          ListTile(
            title: Text('Đánh giá 2'),
            subtitle: Text('Bình luận về nhà hàng'),
          ),
          ListTile(
            title: Text('Đánh giá 3'),
            subtitle: Text('Bình luận về nhà hàng'),
          ),
        ],
      ),
    );
  }
}

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

