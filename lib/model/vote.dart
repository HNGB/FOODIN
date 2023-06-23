class Vote {
  int voteId;
  int reviewId;
  int userId;

  Vote({
    required this.voteId,
    required this.reviewId,
    required this.userId,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      voteId: json['voteId'],
      reviewId: json['reviewId'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'userId': userId,
    };
  }
}
