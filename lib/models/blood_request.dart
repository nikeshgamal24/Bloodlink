import 'dart:convert';

class BloodRequest{

  final String id;
  final String recipientName;
  final String recipientBloodGroup;
  final String hospitalName;
  final String streetName;
  final int postalCode;
  final int ward;
  final String city;
  final String country;
  final DateTime bloodRequiredDate;
  final String caseOfRequest;
  final String? contact;
  final int? phoneNumber;

  BloodRequest({
    required this.id,
    required this.recipientName,
    required this.recipientBloodGroup,
     required this.hospitalName,
    required this.streetName,
    required this.postalCode,
    required this.ward,
    required this.city,
    required this.country,
    required this.bloodRequiredDate,
    required this.caseOfRequest,
    this.contact,
    this.phoneNumber
  });

  //generating the JSON serialization
  Map<String, dynamic> toMap(){
    return{
      "id":id,
      "recipientName":recipientName,
      "recipientBloodGroup":recipientBloodGroup,
      "hospitalName":hospitalName,
      "streetName":streetName,
      "postalCode":postalCode,
      "ward":ward,
      "city":city,
      "country":country,
      "bloodRequiredDate":bloodRequiredDate,
      "caseOfRequest":caseOfRequest,
      "contact":contact,
      "phoneNumber":phoneNumber,
    };
  }

  
  factory BloodRequest.fromMap(Map<String, dynamic> map){
    return BloodRequest(
      id:map['_id'] ?? '',
      recipientName: map['recipientName'] ?? '',
      recipientBloodGroup: map['recipientBloodGroup'] ?? '',
       hospitalName: map['hospitalName'] ?? '',
      streetName: map['streetName'] ?? '',
      postalCode: map['postalCode'] ?? 0,
      ward: map['ward'] ?? 0,
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      bloodRequiredDate: DateTime.parse(map['bloodRequiredDate']),
      caseOfRequest: map['caseOfRequest'] ?? '',
      contact: map['contact'] ?? '',
      phoneNumber: map['phoneNumber'] ?? 0,
    );
  }

  String toJson()=> json.encode(toMap());
//importing dart conver
  factory BloodRequest.fromJson(String source) => BloodRequest.fromMap(json.decode(source));
  
}