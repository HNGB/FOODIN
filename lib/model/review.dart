class Review {
  int reviewId;
  int restaurantId;
  int userId;
  String fullName;
  String dateReview;
  int ratingReview;
  String comment;
  String? image;
  int helpful;
  int unhelpful;

  Review({
    required this.reviewId,
    required this.restaurantId,
    required this.userId,
    required this.fullName,
    required this.dateReview,
    required this.ratingReview,
    required this.comment,
    this.image,
    required this.helpful,
    required this.unhelpful,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'],
      restaurantId: json['restaurantId'],
      userId: json['userId'],
      fullName: json['fullName'],
      dateReview: json['dateReview'],
      ratingReview: json['ratingReview'],
      comment: json['comment'],
      image: json['image'],
      helpful: json['helpful'],
      unhelpful: json['unhelpful'],
    );
  }
}
