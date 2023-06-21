import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/subscription_screen.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/blog.dart';
import '../model/user.dart';
import '../service/blog_service.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewfeedScreenState createState() => _NewfeedScreenState();
}

class _NewfeedScreenState extends State<NewsfeedScreen> {
  int _currentIndex = 3;
  List<Blog> blogs = [];

  final BlogService _blogService = BlogService();
  User? user;
  bool sub = false;
  Future<void> _fetchBlogs() async {
    try {
      List<Blog> fetchedBlogs = await _blogService.getBlogs();
      setState(() {
        blogs = fetchedBlogs;
      });
    } catch (e) {
      print('Failed to load Blogs: $e');
      // Handle the error accordingly
    }
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
          sub = fetchedUser.subscriptionStatus;
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
    getUserFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Newsfeed',
          style: TextStyle(
            color: Colors.orange[700],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: blogs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.only(bottom: 4.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2022/05/hinh-avatar-doi-dep-2022-6-696x696.jpg?fit=700%2C20000&quality=95&ssl=1',
                      ),
                    ),
                    title: GestureDetector(
                      onTap: () async {
                        if (user!.subscriptionStatus == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubscriptionScreen(screen: "NewsFeed"),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String textInput = '';
                              File? imageFile;
                              bool isTextEmpty = true;

                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: FractionallySizedBox(
                                      heightFactor:
                                          null, // Thay đổi heightFactor thành null
                                      widthFactor: 1,
                                      child: Container(
                                        //padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 8, 16, 8),
                                              color: Colors.grey[200],
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  const Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Create Post",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flex(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: isTextEmpty
                                                            ? null
                                                            : () {
                                                                _blogService
                                                                    .createPost(
                                                                        user!
                                                                            .userId,
                                                                        null,
                                                                        textInput,
                                                                        null);
                                                              },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              isTextEmpty
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .orange,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                        child: Text('Post'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Expanded(
                                              flex: 8,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 0),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      textInput = value;
                                                      isTextEmpty =
                                                          value.isEmpty;
                                                    });
                                                  },
                                                  maxLines: null,
                                                  textInputAction:
                                                      TextInputAction.newline,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        "What's on your mind?",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(16.0),
                                              ),
                                              child: Container(
                                                color: Colors.grey[300],
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.photo,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    // Thực hiện logic tải ảnh lên từ điện thoại
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                      child: const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return BlogCard(
              blog: blogs[index - 1],
            );
          }
        },
      ),
      bottomNavigationBar: MyFooter(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class BlogCard extends StatefulWidget {
  final Blog blog;

  const BlogCard({
    required this.blog,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isLiked = false;
  User? user;
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    Color likeIconColor = _isLiked ? Colors.red : Colors.black;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://example.com/avatar.jpg',
              ),
            ),
            title: Text(
              widget.blog.fullName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.blog.createAt,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.blog.blogContent,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
          if (widget.blog.blogImage != null) ...[
            SizedBox(height: 8.0),
            Container(
              constraints: BoxConstraints(maxHeight: 200.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(widget.blog.blogImage!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.thumb_up_off_alt_sharp,
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(widget.blog.likeCount.toString()),
                ],
              ),
              Row(
                children: [
                  Text(widget.blog.commentCount.toString()),
                  const SizedBox(width: 3),
                  const Text("comments"),
                ],
              ),
            ],
          ),
          Divider(height: 1.0, color: Colors.orange[700]),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (user!.subscriptionStatus == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SubscriptionScreen(screen: "NewsFeed"),
                          ),
                        );
                      } else {
                        _toggleLike();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.thumb_up_alt_outlined,
                        color: likeIconColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text("Like"),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (user!.subscriptionStatus == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SubscriptionScreen(screen: "NewsFeed"),
                          ),
                        );
                      } else {
                        _toggleLike();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.comment,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text("Comment"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
