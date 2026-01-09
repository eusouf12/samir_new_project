import 'dart:convert';

class UserProfileModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? country;
  final String? photo;

  UserProfileModel( {
     this.id,
     this.country,
     this.name,
     this.email,
     this.phoneNumber,
     this.dateOfBirth,
     this.photo,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'country': country,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'photo': photo,
    };
  }
}

class Verification {
  final dynamic code;
  final dynamic expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromRawJson(String str) =>
      Verification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate,
  };
}