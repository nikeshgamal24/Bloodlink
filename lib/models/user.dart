import 'dart:convert';

class User {
  final String id;
  final String name;
  final int age;
  final String sex;
  final String phoneNumber;
  final String bloodGroup;
  final String address;
  final String email;
  final String? status;
  final String password;
  final String? role;
  final List<String> faceImage;
  final List<String> governmentDocument;
  final List<String> medicalDocument;
  final String lastDonated;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.address,
    required this.email,
    this.status,
    required this.password,
    this.role,
    required this.faceImage,
    required this.governmentDocument,
    required this.medicalDocument,
    required this.lastDonated,
    required this.token,
  });

  //generating the JSON serialization
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "sex": sex,
      "phoneNumber": phoneNumber,
      "bloodGroup": bloodGroup,
      "address": address,
      "email": email,
      "faceImage": faceImage,
      "governmentDocument": governmentDocument,
      "medicalDocument": medicalDocument,
      "role": role,
      "status": status,
      "password": password,
      "lastDonated": lastDonated,
      "token": token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      sex: map['sex'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      status: map['status'] ?? '',
      password: map['password'] ?? '',
       faceImage: List<String>.from(map['faceImage'] ?? []),
      governmentDocument: List<String>.from(map['governmentDocument'] ?? []),
      medicalDocument: List<String>.from(map['medicalDocument'] ?? []),
      lastDonated: map['lastDonated'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
//importing dart conver
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
