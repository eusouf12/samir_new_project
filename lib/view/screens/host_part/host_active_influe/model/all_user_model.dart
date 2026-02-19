class AllUsersResponse {
  final bool success;
  final String message;
  final AllUserPagination pagination;
  final List<AllUserModel> data;

  AllUsersResponse({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory AllUsersResponse.fromJson(Map<String, dynamic> json) {
    return AllUsersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      pagination: AllUserPagination.fromJson(json['pagination'] ?? {}),
      data: (json['data'] as List<dynamic>? ?? []).map((e) => AllUserModel.fromJson(e)).toList(),
    );
  }
}

class AllUserPagination {
  final int currentPage;
  final int totalPages;
  final int totalUsers;
  final int limit;

  AllUserPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalUsers,
    required this.limit,
  });

  factory AllUserPagination.fromJson(Map<String, dynamic> json) {
    return AllUserPagination(
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalUsers: json['totalUsers'] ?? 0,
      limit: json['limit'] ?? 10,
    );
  }
}

class AllUserModel {
  final String id;
  final int? nightCredits;
  final String name;
  final String email;
  final String role;
  final String status;

  final String? userName;
  final String? image;
  final String? bio;
  final String? aboutMe;

  final String? city;
  final String? state;
  final String? country;
  final String? fullAddress;
  final String? zipCode;
  final String? phone;
  final String? gender;
  final String? dateOfBirth;

  final bool airbnbAccountLinked;
  final bool isFounderMember;
  final bool isStripeConnected;

  final double averageRating;
  final int responseRate;
  final int avgResponseTime;
  final int totalReviews;
  final int referralCount;

  final List<String> nicheTags;
  final List<String> collaborations;
  final List<String> deals;
  final List<String> listings;

  final List<RedeemStar> redeemStars;
  final List<SocialMediaLink> socialMediaLinks;

  final DateTime createdAt;
  final DateTime updatedAt;

  AllUserModel({
    required this.id,
    required this.name,
    this.nightCredits,
    required this.email,
    required this.role,
    required this.status,
    required this.airbnbAccountLinked,
    required this.isFounderMember,
    required this.isStripeConnected,
    required this.averageRating,
    required this.responseRate,
    required this.avgResponseTime,
    required this.totalReviews,
    required this.referralCount,
    required this.nicheTags,
    required this.collaborations,
    required this.deals,
    required this.listings,
    required this.redeemStars,
    required this.socialMediaLinks,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
    this.image,
    this.bio,
    this.aboutMe,
    this.city,
    this.state,
    this.country,
    this.fullAddress,
    this.zipCode,
    this.phone,
    this.gender,
    this.dateOfBirth,
  });

  factory AllUserModel.fromJson(Map<String, dynamic> json) {
    return AllUserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      nightCredits: json['nightCredits'] ?? 0,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? 'inactive',
      userName: json['userName'],
      image: json['image'],
      bio: json['bio'],
      aboutMe: json['aboutMe'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      fullAddress: json['fullAddress'] ?? "",
      zipCode: json['zipCode'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],

      airbnbAccountLinked: json['airbnbAccountLinked'] ?? false,
      isFounderMember: json['isFounderMember'] ?? false,
      isStripeConnected: json['isStripeConnected'] ?? false,

      averageRating: (json['averageRating'] ?? 0).toDouble(),
      responseRate: json['responseRate'] ?? 0,
      avgResponseTime: json['avgResponseTime'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
      referralCount: json['referralCount'] ?? 0,

      nicheTags: (json['nicheTags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      collaborations: (json['collaborations'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      deals: (json['deals'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      listings: (json['listings'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      redeemStars: (json['redeemStars'] as List<dynamic>? ?? [])
          .map((e) => RedeemStar.fromJson(e))
          .toList(),

      socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>? ?? [])
          .map((e) => SocialMediaLink.fromJson(e))
          .toList(),

      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}


class RedeemStar {
  final String? id;
  final String? collaborationId;
  final DateTime? createdAt;

  RedeemStar({
    this.id,
    this.collaborationId,
    this.createdAt,
  });

  factory RedeemStar.fromJson(Map<String, dynamic> json) {
    return RedeemStar(
      id: json['_id'],
      collaborationId: json['collaborationId'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}

class SocialMediaLink {
  final String id;
  final String platform;
  final String url;
  final String followers;

  SocialMediaLink({
    required this.id,
    required this.platform,
    required this.url,
    required this.followers,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: json['_id'] ?? '',
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
      followers: json['followers'] ?? "0",
    );
  }
}



