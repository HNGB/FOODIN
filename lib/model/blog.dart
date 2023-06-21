class Blog {
  final int blogId;
  final int userId;
  final String fullName;
  final String? title;
  final String blogContent;
  final int likeCount;
  final int commentCount;
  final String createAt;
  final String? blogImage;

  Blog({
    required this.blogId,
    required this.userId,
    required this.fullName,
    this.title,
    required this.blogContent,
    required this.likeCount,
    required this.commentCount,
    required this.createAt,
    this.blogImage,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      blogId: json['blogId'],
      userId: json['userId'],
      fullName: json['fullName'],
      title: json['title'],
      blogContent: json['blogContent'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createAt: json['createAt'],
      blogImage: json['blogImage'],
    );
  }
}
