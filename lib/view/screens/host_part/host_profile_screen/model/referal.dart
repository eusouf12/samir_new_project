class ReferralResponse {
  final bool? success;
  final String? message;
  final ReferralData? data;

  ReferralResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ReferralResponse.fromJson(Map<String, dynamic> json) {
    return ReferralResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? ReferralData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class ReferralData {
  final String? referralCode;
  final int? referralCount;
  final List<ReferralItem>? referrals;
  final List<ReferralItem>? referredUsers;

  ReferralData({
    this.referralCode,
    this.referralCount,
    this.referrals,
    this.referredUsers,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      referralCode: json["referralCode"],
      referralCount: json["referralCount"],
      referrals: (json["referrals"] as List?)
              ?.map((e) => ReferralItem.fromJson(e))
              .toList() ??
          [],
      referredUsers: (json["referredUsers"] as List?)
              ?.map((e) => ReferralItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "referralCode": referralCode,
      "referralCount": referralCount,
      "referrals": referrals?.map((e) => e.toJson()).toList(),
      "referredUsers": referredUsers?.map((e) => e.toJson()).toList(),
    };
  }
}

/// Placeholder model
/// Update fields when the API starts returning data.
class ReferralItem {
  final String? name;
  final String? pic;
  final String? date;

  ReferralItem({
    this.name,
    this.pic,
    this.date,
  });

  factory ReferralItem.fromJson(Map<String, dynamic> json) {
    return ReferralItem(
      name: json["name"],
      pic: json["pic"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "pic": pic,
      "date": date,
    };
  }
}