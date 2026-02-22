class UserResponse {
  final bool success;
  final UserData data;

  UserResponse({
    required this.success,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      data: UserData.fromJson(json['data']),
    );
  }
}
class UserData {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String dateOfBirth;
  final String phone;
  final String role;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool airbnbAccountLinked;
  final int avgResponseTime;
  final List<dynamic> collaborations;
  final int collaborationsTotal;
  final List<dynamic> completeDeals;
  final int completeDealsTotal;
  final List<dynamic> deals;
  final int dealsTotal;
  final List<String> listings;
  final int listingsTotal;
  final List<dynamic> nicheTags;
  final int responseRate;
  final String fullAddress;
  final String country;
  final String image;
  final List<UserRedeemStar>? redeemStars;
  final List<UserSocialMedia>? socialMediaLinks;
  final UserCollaborationStats? collaborationStats;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.phone,
    required this.dateOfBirth,
    required this.role,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.airbnbAccountLinked,
    required this.avgResponseTime,
    required this.collaborations,
    required this.collaborationsTotal,
    required this.completeDeals,
    required this.completeDealsTotal,
    required this.deals,
    required this.dealsTotal,
    required this.listings,
    required this.listingsTotal,
    required this.nicheTags,
    required this.responseRate,
    required this.fullAddress,
    required this.country,
    required this.image,
    this.redeemStars,
    this.socialMediaLinks,
    this.collaborationStats,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
      airbnbAccountLinked: json['airbnbAccountLinked'] ?? false,
      avgResponseTime: json['avgResponseTime'] ?? 0,
      collaborations: List<dynamic>.from(json['collaborations'] ?? []),
      collaborationsTotal: json['collaborationsTotal'] ?? 0,
      completeDeals: List<dynamic>.from(json['completeDeals'] ?? []),
      completeDealsTotal: json['completeDealsTotal'] ?? 0,
      deals: List<dynamic>.from(json['deals'] ?? []),
      dealsTotal: json['dealsTotal'] ?? 0,
      listings: List<String>.from(json['listings'] ?? []),
      listingsTotal: json['listingsTotal'] ?? 0,
      nicheTags: List<dynamic>.from(json['nicheTags'] ?? []),
      responseRate: json['responseRate'] ?? 0,
      fullAddress: json['fullAddress'] ?? '',
      country: json['country'] ?? '',
      image: json['image'] ?? '',
      redeemStars: (json['redeemStars'] as List?)?.map((e) => UserRedeemStar.fromJson(e)).toList(),
      socialMediaLinks: (json['socialMediaLinks'] as List?)?.map((e) => UserSocialMedia.fromJson(e)).toList(),
      collaborationStats: json['collaborationStats'] != null ? UserCollaborationStats.fromJson(json['collaborationStats']) : null,
    );
  }
}

class UserSocialMedia {
  String? id;
  String? platform;
  String? url;
  String? followers;

  UserSocialMedia({
    this.id,
    this.platform,
    this.url,
    this.followers,
  });

  factory UserSocialMedia.fromJson(Map<String, dynamic> json) {
    return UserSocialMedia(
      id: json['_id'],
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
      followers: json['followers'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "platform": platform,
      "url": url,
      "followers": followers,
    };
  }
}

class UserCollaborationStats {
  final int? total;
  final UserCollaborationStatItem? pending;
  final UserCollaborationStatItem? negotiating;
  final UserCollaborationStatItem? accepted;
  final UserCollaborationStatItem? ongoing;
  final UserCollaborationStatItem? completed;
  final UserCollaborationStatItem? rejected;

  UserCollaborationStats({
    this.total,
    this.pending,
    this.negotiating,
    this.accepted,
    this.ongoing,
    this.completed,
    this.rejected,
  });

  factory UserCollaborationStats.fromJson(Map<String, dynamic> json) {
    return UserCollaborationStats(
      total: json['total'],
      pending: json['pending'] != null
          ? UserCollaborationStatItem.fromJson(json['pending'])
          : null,
      negotiating: json['negotiating'] != null
          ? UserCollaborationStatItem.fromJson(json['negotiating'])
          : null,
      accepted: json['accepted'] != null
          ? UserCollaborationStatItem.fromJson(json['accepted'])
          : null,
      ongoing: json['ongoing'] != null
          ? UserCollaborationStatItem.fromJson(json['ongoing'])
          : null,
      completed: json['completed'] != null
          ? UserCollaborationStatItem.fromJson(json['completed'])
          : null,
      rejected: json['rejected'] != null
          ? UserCollaborationStatItem.fromJson(json['rejected'])
          : null,
    );
  }
}

class UserRedeemStar {
  final String? id;
  final String? collaborationId;
  final String? createdAt;

  UserRedeemStar({
    this.id,
    this.collaborationId,
    this.createdAt,
  });

  factory UserRedeemStar.fromJson(Map<String, dynamic> json) {
    return UserRedeemStar(
      id: json['_id'],
      collaborationId: json['collaborationId'],
      createdAt: json['createdAt'],
    );
  }
}

class UserCollaborationStatItem {
  final int? count;
  final int? totalCompensation;
  final int? totalNights;
  final int? avgCompensation;
  final int? avgNights;

  UserCollaborationStatItem({
    this.count,
    this.totalCompensation,
    this.totalNights,
    this.avgCompensation,
    this.avgNights,
  });

  factory UserCollaborationStatItem.fromJson(Map<String, dynamic> json) {
    return UserCollaborationStatItem(
      count: json['count'],
      totalCompensation: json['totalCompensation'],
      totalNights: json['totalNights'],
      avgCompensation: json['avgCompensation'],
      avgNights: json['avgNights'],
    );
  }
}