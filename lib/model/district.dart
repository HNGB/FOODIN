class District {
  final int districtId;
  final String districtName;
  final int cityId;
  final String? city;
  final List<String>? restaurants;

  District({
    required this.districtId,
    required this.districtName,
    required this.cityId,
    this.city,
    this.restaurants,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtId: json['districtId'],
      districtName: json['districtName'],
      cityId: json['cityId'],
      city: json['city'],
      restaurants: List<String>.from(json['restaurants']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'districtId': districtId,
      'districtName': districtName,
      'cityId': cityId,
      'city': city,
      'restaurants': restaurants,
    };
  }
}
