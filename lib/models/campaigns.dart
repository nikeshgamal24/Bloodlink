import 'dart:convert';

class Campaign {
  final String id;
  final String campaignTitle;
  final String campaignDays;
  final String campaignDayStatus;
  final String campaignStartTime;
  final String campaignEndTime;
  final String campaignEndDate;
  final String streetName;
  final int postalCode;
  final int ward;
  final String city;
  final String country;
  final String campaignLongitude;
  final String campaignLatitude;
  final int goalPint;

  final String campaignOrganizer;
  final String campaignEmail;
  final int campaignContact;

  Campaign({
    required this.id,
    required this.campaignTitle,
    required this.campaignDays,
    required this.campaignDayStatus,
    required this.campaignStartTime,
    required this.campaignEndTime,
    required this.campaignEndDate,
    required this.streetName,
    required this.postalCode,
    required this.ward,
    required this.city,
    required this.country,
    required this.campaignLongitude,
    required this.campaignLatitude,
    required this.goalPint,
    required this.campaignOrganizer,
    required this.campaignEmail,
    required this.campaignContact,
  });

  //generating the JSON serialization
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "campaignTitle": campaignTitle,
      "campaignDays": campaignDays,
      "campaignDayStatus": campaignDayStatus,
      "campaignStartTime": campaignStartTime,
      "campaignEndTime": campaignEndTime,
      "campaignEndDate": campaignEndDate,
      "streetName": streetName,
      "postalCode": postalCode,
      "ward": ward,
      "city": city,
      "country": country,
      "campaignLongitude": campaignLongitude,
      "campaignLatitude": campaignLatitude,
      "goalPint": goalPint,
      "campaignOrganizer": campaignOrganizer,
      "campaignEmail": campaignEmail,
      "campaignContact": campaignContact,
    };
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['_id'] ?? '',
      campaignTitle: map['campaignTitle'] ?? '',
      campaignDays: map['campaignDays'] ?? '',
      campaignDayStatus: map['campaignDayStatus'] ?? '',
      campaignStartTime: map['campaignStartTime'] ?? '',
      campaignEndTime: map['campaignEndTime'] ?? '',
      campaignEndDate: map['campaignEndDate']?? '',
      streetName: map['streetName'] ?? '',
      postalCode: map['postalCode'] ?? 0,
      ward: map['ward'] ?? 0,
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      campaignLongitude: map['campaignLongitude'] ?? '',
      campaignLatitude: map['campaignLatitude'] ?? '',
      goalPint: map['goalPint'] ?? 0,
      campaignOrganizer: map['campaignOrganizer'] ?? '',
      campaignEmail: map['campaignEmail'] ?? '',
      campaignContact: map['campaignContact'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
//importing dart conver
  factory Campaign.fromJson(String source) =>
      Campaign.fromMap(json.decode(source));
}
