class Food {
  final String foodName;
  final int foodPrice;
  final String foodImage;
  final String? typeFoodName;

  Food({
    required this.foodName,
    required this.foodPrice,
    required this.foodImage,
    this.typeFoodName,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodName: json['foodName'] as String,
      foodPrice: json['foodPrice'] as int,
      foodImage: json['foodImage'] as String,
      typeFoodName: json['typeFoodName'] as String?,
    );
  }
}
