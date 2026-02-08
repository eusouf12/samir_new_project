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
  final String? city;
  final String? country;
  final String? fullAddress;
  final String? phone;
  final String? gender;
  final String? dateOfBirth;
  final String? state;
  final String? zipCode;
  final bool? isFounderMember;
  final bool? airbnbAccountLinked;
  final int? totalReviews;
  final int? referralCount;
  final int? responseRate;
  final int? avgResponseTime;
  final int? collaborationsTotal;
  final int? dealsTotal;
  final int? totalListings;
  final String? status;

  final List<String>? deals;
  final List<String>? listings;
  final List<SingleUserRedeemStar>? redeemStars;
  final SingleUserCollaborationStats? collaborationStats;

  SingleUserProfileData({
    this.id,
    this.name,
    this.email,
    this.userName,
    this.role,
    this.image,
    this.city,
    this.country,
    this.fullAddress,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.state,
    this.zipCode,
    this.isFounderMember,
    this.airbnbAccountLinked,
    this.totalReviews,
    this.referralCount,
    this.responseRate,
    this.avgResponseTime,
    this.collaborationsTotal,
    this.dealsTotal,
    this.totalListings,
    this.status,
    this.deals,
    this.listings,
    this.redeemStars,
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
      city: json['city'],
      country: json['country'],
      fullAddress: json['fullAddress'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      state: json['state'],
      zipCode: json['zipCode'],
      isFounderMember: json['isFounderMember'],
      airbnbAccountLinked: json['airbnbAccountLinked'],
      totalReviews: json['totalReviews'],
      referralCount: json['referralCount'],
      responseRate: json['responseRate'],
      avgResponseTime: json['avgResponseTime'],
      collaborationsTotal: json['collaborationsTotal'],
      dealsTotal: json['dealsTotal'],
      totalListings: json['totalListings'],
      status: json['status'],
      deals: (json['deals'] as List?)?.cast<String>(),
      listings: (json['listings'] as List?)?.cast<String>(),
      redeemStars: (json['redeemStars'] as List?)?.map((e) => SingleUserRedeemStar.fromJson(e)).toList(),
      collaborationStats: json['collaborationStats'] != null ? SingleUserCollaborationStats.fromJson(json['collaborationStats']) : null,
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
