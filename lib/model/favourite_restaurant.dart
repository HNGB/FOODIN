class FavouriteRestaurant {
  int restaurantId;
  String resName;
  String address;
  String? phoneNumber;
  String avatar;
  int calculatedRating;
  FavouriteRestaurant({
    required this.restaurantId,
    required this.resName,
    required this.address,
    this.phoneNumber,
    required this.avatar,
    required this.calculatedRating,
  });

  factory FavouriteRestaurant.fromJson(Map<String, dynamic> json) {
    return FavouriteRestaurant(
        restaurantId: json['restaurantId'],
        resName: json['resName'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        avatar: json['avatar'],
        calculatedRating: json['calculatedRating']);
  }
}
