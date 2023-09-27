import 'dart:convert';

class BloodRequest {
  final String id;
  final String recipientName;
  final String recipientBloodGroup;
  int? requiredPints;
  int? otp;
  final String hospitalName;
  final String streetName;
  final int postalCode;
  final int ward;
  final String city;
  final String country;
  double? longitude;
  double? latitude;
  int? pintCollectedCount;
  List<dynamic>? acceptors;
  final String bloodRequiredDate;
  final String caseOfRequest;
  final String? contactOfRequestCreator;
  final int? phoneNumberOfRequest;

  BloodRequest({
    required this.id,
    required this.recipientName,
    required this.recipientBloodGroup,
    this.requiredPints,
    this.pintCollectedCount,
    this.otp,
    required this.hospitalName,
    required this.streetName,
    required this.postalCode,
    required this.ward,
    required this.city,
    required this.country,
    this.longitude,
    this.latitude,
    this.acceptors,
    required this.bloodRequiredDate,
    required this.caseOfRequest,
    this.contactOfRequestCreator,
    this.phoneNumberOfRequest,
  });

  //generating the JSON serialization
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "recipientName": recipientName,
      "recipientBloodGroup": recipientBloodGroup,
      "requiredPints": requiredPints,
      "pintCollectedCount":pintCollectedCount,
      "otp": otp,
      "hospitalName": hospitalName,
      "streetName": streetName,
      "postalCode": postalCode,
      "ward": ward,
      "city": city,
      "country": country,
      "longitude":longitude,
      "latitude":latitude,
      "acceptors": acceptors,
      "bloodRequiredDate": bloodRequiredDate,
      "caseOfRequest": caseOfRequest,
      "contactOfRequestCreator": contactOfRequestCreator,
      "phoneNumberOfRequestCreator": phoneNumberOfRequest,
    };
  }

  factory BloodRequest.fromMap(Map<String, dynamic> map) {
    List<dynamic>? acceptors = map['acceptors'] as List<dynamic>?;
    return BloodRequest(
      id: map['_id'] ?? '',
      recipientName: map['recipientName'] ?? '',
      recipientBloodGroup: map['recipientBloodGroup'] ?? '',
      requiredPints: map['requiredPints'] ?? 0,
       pintCollectedCount: map['pintCollectedCount'] ?? 0,
      otp: map['otp'] ?? 0,
      hospitalName: map['hospitalName'] ?? '',
      streetName: map['streetName'] ?? '',
      postalCode: map['postalCode'] ?? 0,
      ward: map['ward'] ?? 0,
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      longitude: map['longitude'] ?? 0.0,
      latitude: map['latitude'] ?? 0.0,
      acceptors:acceptors,
      bloodRequiredDate: map['bloodRequiredDate']??'',
      caseOfRequest: map['caseOfRequest'] ?? '',
      contactOfRequestCreator: map['contactOfRequestCreator'] ?? '',
      phoneNumberOfRequest: map['phoneNumberOfRequest'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
//importing dart conver
  factory BloodRequest.fromJson(String source) =>
      BloodRequest.fromMap(json.decode(source));
}
