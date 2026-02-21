class SingleUserProfileResponse {
  final bool? success;
  final String? message;
  final SingleUserProfileData? data;

  SingleUserProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SingleUserProfileResponse.fromJson(Map<String, dynamic> json) {
    return SingleUserProfileResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? SingleUserProfileData.fromJson(json['data'])
          : null,
    );
  }
}

class SingleUserProfileData {
  final String? id;
  final String? name;
  final String? email;
  final String? userName;
  final String? role;
  final String? image;
  final String? bio;
  final String? aboutMe;
  final String? city;
  final String? country;
  final String? fullAddress;
  final String? phone;
  final String? gender;
  final String? dateOfBirth;
  final String? state;
  final String? zipCode;
  final String? status;
  final String? stripeAccountId;
  final String? createdAt;
  final String? updatedAt;

  final bool? isFounderMember;
  final bool? airbnbAccountLinked;
  final bool? issn;
  final bool? isStripeConnected;

  final int? totalReviews;
  final int? referralCount;
  final int? responseRate;
  final int? avgResponseTime;
  final int? collaborationsTotal;
  final int? dealsTotal;
  final int? totalListings;
  final int? completeDealsTotal;
  final int? averageRating;
  final int? nightCredits;
  final int? totalRedeemStars;
  final int? isNoMember;

  final List<String>? deals;
  final List<String>? listings;
  final List<String>? collaborations;
  final List<String>? completeDeals;
  final List<String>? nicheTags;

  final List<SingleUserRedeemStar>? redeemStars;
  final List<SingleUserSocialMedia>? socialMediaLinks;

  final SingleUserCollaborationStats? collaborationStats;

  SingleUserProfileData({
    this.id,
    this.name,
    this.email,
    this.userName,
    this.role,
    this.image,
    this.bio,
    this.aboutMe,
    this.city,
    this.country,
    this.fullAddress,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.state,
    this.zipCode,
    this.status,
    this.stripeAccountId,
    this.createdAt,
    this.updatedAt,
    this.isFounderMember,
    this.airbnbAccountLinked,
    this.issn,
    this.isStripeConnected,
    this.totalReviews,
    this.referralCount,
    this.responseRate,
    this.avgResponseTime,
    this.collaborationsTotal,
    this.dealsTotal,
    this.totalListings,
    this.completeDealsTotal,
    this.averageRating,
    this.nightCredits,
    this.totalRedeemStars,
    this.isNoMember,
    this.deals,
    this.listings,
    this.collaborations,
    this.completeDeals,
    this.nicheTags,
    this.redeemStars,
    this.socialMediaLinks,
    this.collaborationStats,
  });

  factory SingleUserProfileData.fromJson(Map<String, dynamic> json) {
    return SingleUserProfileData(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      userName: json['userName'],
      role: json['role'],
      image: json['image'],
      bio: json['bio'],
      aboutMe: json['aboutMe'],
      city: json['city'],
      country: json['country'],
      fullAddress: json['fullAddress'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      state: json['state'],
      zipCode: json['zipCode'],
      status: json['status'],
      stripeAccountId: json['stripeAccountId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isFounderMember: json['isFounderMember'],
      airbnbAccountLinked: json['airbnbAccountLinked'],
      issn: json['issn'],
      isStripeConnected: json['isStripeConnected'],
      totalReviews: json['totalReviews'],
      referralCount: json['referralCount'],
      responseRate: json['responseRate'],
      avgResponseTime: json['avgResponseTime'],
      collaborationsTotal: json['collaborationsTotal'],
      dealsTotal: json['dealsTotal'],
      totalListings: json['totalListings'],
      completeDealsTotal: json['completeDealsTotal'],
      averageRating: json['averageRating'],
      nightCredits: json['nightCredits'],
      totalRedeemStars: json['totalRedeemStars'],
      isNoMember: json['isNoMember'],
      deals: (json['deals'] as List?)?.cast<String>(),
      listings: (json['listings'] as List?)?.cast<String>(),
      collaborations: (json['collaborations'] as List?)?.cast<String>(),
      completeDeals: (json['completeDeals'] as List?)?.cast<String>(),
      nicheTags: (json['nicheTags'] as List?)?.cast<String>(),
      redeemStars: (json['redeemStars'] as List?)
          ?.map((e) => SingleUserRedeemStar.fromJson(e))
          .toList(),
      socialMediaLinks: (json['socialMediaLinks'] as List?)
          ?.map((e) => SingleUserSocialMedia.fromJson(e))
          .toList(),
      collaborationStats: json['collaborationStats'] != null
          ? SingleUserCollaborationStats.fromJson(json['collaborationStats'])
          : null,
    );
  }
}

class SingleUserSocialMedia {
  final String? id;
  final String? platform;
  final String? url;
  final String? followers;

  SingleUserSocialMedia({
    this.id,
    this.platform,
    this.url,
    this.followers,
  });

  factory SingleUserSocialMedia.fromJson(Map<String, dynamic> json) {
    return SingleUserSocialMedia(
      id: json['_id'],
      platform: json['platform'],
      url: json['url'],
      followers: json['followers'],
    );
  }
}

class SingleUserRedeemStar {
  final String? id;
  final String? collaborationId;
  final String? createdAt;

  SingleUserRedeemStar({
    this.id,
    this.collaborationId,
    this.createdAt,
  });

  factory SingleUserRedeemStar.fromJson(Map<String, dynamic> json) {
    return SingleUserRedeemStar(
      id: json['_id'],
      collaborationId: json['collaborationId'],
      createdAt: json['createdAt'],
    );
  }
}

class SingleUserCollaborationStats {
  final int? total;
  final SingleUserCollaborationStatItem? pending;
  final SingleUserCollaborationStatItem? negotiating;
  final SingleUserCollaborationStatItem? accepted;
  final SingleUserCollaborationStatItem? ongoing;
  final SingleUserCollaborationStatItem? completed;
  final SingleUserCollaborationStatItem? rejected;

  SingleUserCollaborationStats({
    this.total,
    this.pending,
    this.negotiating,
    this.accepted,
    this.ongoing,
    this.completed,
    this.rejected,
  });

  factory SingleUserCollaborationStats.fromJson(Map<String, dynamic> json) {
    return SingleUserCollaborationStats(
      total: json['total'],
      pending: json['pending'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['pending'])
          : null,
      negotiating: json['negotiating'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['negotiating'])
          : null,
      accepted: json['accepted'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['accepted'])
          : null,
      ongoing: json['ongoing'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['ongoing'])
          : null,
      completed: json['completed'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['completed'])
          : null,
      rejected: json['rejected'] != null
          ? SingleUserCollaborationStatItem.fromJson(json['rejected'])
          : null,
    );
  }
}

class SingleUserCollaborationStatItem {
  final int? count;
  final int? totalCompensation;
  final int? totalNights;
  final int? avgCompensation;
  final int? avgNights;

  SingleUserCollaborationStatItem({
    this.count,
    this.totalCompensation,
    this.totalNights,
    this.avgCompensation,
    this.avgNights,
  });

  factory SingleUserCollaborationStatItem.fromJson(Map<String, dynamic> json) {
    return SingleUserCollaborationStatItem(
      count: json['count'],
      totalCompensation: json['totalCompensation'],
      totalNights: json['totalNights'],
      avgCompensation: json['avgCompensation'],
      avgNights: json['avgNights'],
    );
  }
}
