class User {
  int userId;
  String fullName;
  String email;
  String phoneNumber;
  String userName;
  String password;
  bool subscriptionStatus;
  List<dynamic>? blogs;
  List<dynamic>? comments;
  List<dynamic>? favorites;
  List<dynamic>? likes;
  List<dynamic>? reviews;
  List<dynamic>? votes;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userName,
    required this.password,
    required this.subscriptionStatus,
    this.blogs,
    this.comments,
    this.favorites,
    this.likes,
    this.reviews,
    this.votes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userName: json['userName'],
      password: json['password'],
      subscriptionStatus: json['subscriptionStatus'],
      blogs: json['blogs'],
      comments: json['comments'],
      favorites: json['favorites'],
      likes: json['likes'],
      reviews: json['reviews'],
      votes: json['votes'],
    );
  }
}
