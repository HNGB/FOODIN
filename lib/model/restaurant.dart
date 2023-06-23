class Restaurant {
  int restaurantId;
  String resName;
  String address;
  int districtId;
  String? phoneNumber;
  int ratingId;
  String avatar;
  String coverImage;
  double? calculatedRating;
  Restaurant({
    required this.restaurantId,
    required this.resName,
    required this.address,
    required this.districtId,
    this.phoneNumber,
    required this.ratingId,
    required this.avatar,
    required this.coverImage,
    this.calculatedRating,
  });
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        restaurantId: json['restaurantId'],
        resName: json['resName'],
        address: json['address'],
        districtId: json['districtId'],
        phoneNumber: json['phoneNumber'],
        ratingId: json['ratingId'],
        avatar: json['avatar'],
        coverImage: json['coverImage'],
        calculatedRating: json['calculatedRating']?.toDouble());
  }
}
