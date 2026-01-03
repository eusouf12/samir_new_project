// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';
PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));
String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  final String? id;
  final String? privacyPolicy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PrivacyModel({
    this.id,
    this.privacyPolicy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PrivacyModel copyWith({
    String? id,
    String? privacyPolicy,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      PrivacyModel(
        id: id ?? this.id,
        privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    id: json["_id"],
    privacyPolicy: json["PrivacyPolicy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "PrivacyPolicy": privacyPolicy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

