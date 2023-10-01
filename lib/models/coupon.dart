import 'dart:convert';

class Coupon {
  final String id;
  final int disountPercentage;
  final String description;
  final int pointCost;
  final int availablePoints;

  Coupon({
    required this.id,
    required this.disountPercentage,
    required this.description,
    required this.pointCost,
    required this.availablePoints,
  });

  //generating the JSON serialization
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "disountPercentage": disountPercentage,
      "description": description,
      "pointCost": pointCost,
      "availablePoints": availablePoints,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['_id'] ?? '',
      disountPercentage: map['disountPercentage'] ?? 0,
      description: map['description'] ?? '',
      pointCost: map['pointCost'] ?? 0,
      availablePoints: map['availablePoints'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
//importing dart conver
  factory Coupon.fromJson(String source) => Coupon.fromMap(json.decode(source));
}
