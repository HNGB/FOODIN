import 'district.dart';

class City {
  final int cityId;
  final String cityName;
  final List<District>? districts;

  City({
    required this.cityId,
    required this.cityName,
    this.districts,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['cityId'],
      cityName: json['cityName'],
      districts: List<District>.from(json['districts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'cityName': cityName,
      'districts': districts,
    };
  }
}
