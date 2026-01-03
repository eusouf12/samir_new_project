
import 'dart:convert';

TermsModel termsModelFromJson(String str) =>
    TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel {
  final String? id;
  final String? termsCondition;
  final DateTime? createdAt;
  final int? v;

  TermsModel({
    this.id,
    this.termsCondition,
    this.createdAt,
    this.v,
  });

  TermsModel copyWith({
    String? id,
    String? termsCondition,
    DateTime? createdAt,
    int? v,
  }) =>
      TermsModel(
        id: id ?? this.id,
        termsCondition: termsCondition ?? this.termsCondition,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    id: json["_id"],
    termsCondition: json["TermsConditions"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "TermsConditions": termsCondition,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}