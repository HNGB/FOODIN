import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewfeedScreenState createState() => _NewfeedScreenState();
}

class _NewfeedScreenState extends State<NewsfeedScreen> {
  int _currentIndex = 3;
  List<Post> posts = [
    Post(
      name: 'John Doe',
      time: '5 minutes ago',
      content: 'Out with gf!',
      imageUrl:
          'https://tq1.mediacdn.vn/thumb_w/660/203336854389633024/2022/7/3/photo-1-16568123294431720512228.jpg',
    ),
    Post(
      name: 'Jane Smith',
      time: '1 hour ago',
      content: 'Hello, everyone!',
      imageUrl: null,
    ),
    Post(
      name: 'Alex Johnson',
      time: '2 hours ago',
      content: 'Check out this amazing photo!',
      imageUrl: 'https://example.com/photo.jpg',
    ),
    Post(
      name: 'Emily Brown',
      time: '4 hours ago',
      content: 'Feeling blessed today.',
      imageUrl: null,
    ),
    Post(
      name: 'Michael Wilson',
      time: '1 day ago',
      content: 'Just a random thought...',
      imageUrl: null,
    ),
  ];

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
        itemCount: posts.length + 1,
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
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/avatar.jpg',
                      ),
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return PostCard(
              post: posts[index - 1],
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

class Post {
  final String name;
  final String time;
  final String content;
  final String? imageUrl;

  Post({
    required this.name,
    required this.time,
    required this.content,
    required this.imageUrl,
  });
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    required this.post,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
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
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://example.com/avatar.jpg',
              ),
            ),
            title: Text(
              widget.post.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.post.time,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.post.content,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
          if (widget.post.imageUrl != null) ...[
            SizedBox(height: 8.0),
            Container(
              constraints: BoxConstraints(maxHeight: 200.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(widget.post.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          SizedBox(height: 8.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("25,5K"),
                ],
              ),
              Row(
                children: [
                  Text("1000 commnets"),
                ],
              ),
            ],
          ),
          Divider(height: 1.0, color: Colors.orange[700]),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: _toggleLike,
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
                    onTap: _toggleLike,
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
