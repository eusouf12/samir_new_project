class SingleUserCollaborationResponse {
  final bool? success;
  final String? message;
  final int? count;
  final String? status;
  final List<SingleUserCollaborationData>? data;

  SingleUserCollaborationResponse({
    this.success,
    this.message,
    this.count,
    this.status,
    this.data,
  });

  factory SingleUserCollaborationResponse.fromJson(Map<String, dynamic> json) {
    return SingleUserCollaborationResponse(
      success: json['success'],
      message: json['message'],
      count: json['count'],
      status: json['status'],
      data: (json['data'] as List?)
          ?.map((e) => SingleUserCollaborationData.fromJson(e))
          .toList(),
    );
  }
}

class SingleUserCollaborationData {
  final String? id;
  final SingleUserInfo? userId;
  final SingleUserInfo? selectInfluencerOrHost;
  final SingleUserDealInfo? selectDeal;
  final String? status;
  final String? negotiationStatus;
  final String? paymentStatus;
  final String? rejectReason;
  final SingleUserSocialMediaLinks? socialMediaLinks;
  final String? createdAt;
  final String? updatedAt;

  SingleUserCollaborationData({
    this.id,
    this.userId,
    this.selectInfluencerOrHost,
    this.selectDeal,
    this.status,
    this.negotiationStatus,
    this.paymentStatus,
    this.rejectReason,
    this.socialMediaLinks,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleUserCollaborationData.fromJson(Map<String, dynamic> json) {
    return SingleUserCollaborationData(
      id: json['_id'],
      userId: json['userId'] != null
          ? SingleUserInfo.fromJson(json['userId'])
          : null,
      selectInfluencerOrHost: json['selectInfluencerOrHost'] != null
          ? SingleUserInfo.fromJson(json['selectInfluencerOrHost'])
          : null,
      selectDeal: json['selectDeal'] != null
          ? SingleUserDealInfo.fromJson(json['selectDeal'])
          : null,
      status: json['status'],
      negotiationStatus: json['negotiationStatus'],
      paymentStatus: json['paymentStatus'],
      rejectReason: json['rejectReason'],
      socialMediaLinks: json['socialMediaLinks'] != null
          ? SingleUserSocialMediaLinks.fromJson(json['socialMediaLinks'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class SingleUserInfo {
  final String? id;
  final String? name;
  final String? email;
  final String? role;

  SingleUserInfo({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  factory SingleUserInfo.fromJson(Map<String, dynamic> json) {
    return SingleUserInfo(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class SingleUserDealInfo {
  final String? id;
  final String? dealTitle;
  final String? description;
  final SingleUserListingInfo? selectListing;
  final SingleUserCompensation? compensation;
  final String? addAirbnbLink;
  final String? inTimeAndDate;
  final String? outTimeAndDate;
  final String? status;
  final List<SingleUserDeliverable>? deliverables;

  SingleUserDealInfo({
    this.id,
    this.dealTitle,
    this.description,
    this.selectListing,
    this.compensation,
    this.addAirbnbLink,
    this.inTimeAndDate,
    this.outTimeAndDate,
    this.status,
    this.deliverables,
  });

  factory SingleUserDealInfo.fromJson(Map<String, dynamic> json) {
    return SingleUserDealInfo(
      id: json['_id'],
      dealTitle: json['dealTitle'],
      description: json['description'],
      selectListing: json['selectListing'] != null
          ? SingleUserListingInfo.fromJson(json['selectListing'])
          : null,
      compensation: json['compensation'] != null
          ? SingleUserCompensation.fromJson(json['compensation'])
          : null,
      addAirbnbLink: json['addAirbnbLink'],
      inTimeAndDate: json['inTimeAndDate'],
      outTimeAndDate: json['outTimeAndDate'],
      status: json['status'],
      deliverables: (json['deliverables'] as List?)
          ?.map((e) => SingleUserDeliverable.fromJson(e))
          .toList(),
    );
  }
}

class SingleUserListingInfo {
  final String? id;
  final String? title;
  final String? description;
  final String? location;
  final String? propertyType;
  final List<String>? images;

  SingleUserListingInfo({
    this.id,
    this.title,
    this.description,
    this.location,
    this.propertyType,
    this.images,
  });

  factory SingleUserListingInfo.fromJson(Map<String, dynamic> json) {
    return SingleUserListingInfo(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      propertyType: json['propertyType'],
      images: (json['images'] as List?)?.cast<String>(),
    );
  }
}

class SingleUserCompensation {
  final bool? nightCredits;
  final int? numberOfNights;
  final bool? directPayment;
  final String? paymentAmount;

  SingleUserCompensation({
    this.nightCredits,
    this.numberOfNights,
    this.directPayment,
    this.paymentAmount,
  });

  factory SingleUserCompensation.fromJson(Map<String, dynamic> json) {
    return SingleUserCompensation(
      nightCredits: json['nightCredits'],
      numberOfNights: json['numberOfNights'],
      directPayment: json['directPayment'],
      paymentAmount: json['paymentAmount'],
    );
  }
}

class SingleUserDeliverable {
  final String? platform;
  final String? contentType;
  final int? quantity;

  SingleUserDeliverable({
    this.platform,
    this.contentType,
    this.quantity,
  });

  factory SingleUserDeliverable.fromJson(Map<String, dynamic> json) {
    return SingleUserDeliverable(
      platform: json['platform'],
      contentType: json['contentType'],
      quantity: json['quantity'],
    );
  }
}

class SingleUserSocialMediaLinks {
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final String? youtube;
  final String? tiktok;

  SingleUserSocialMediaLinks({
    this.instagram,
    this.facebook,
    this.twitter,
    this.youtube,
    this.tiktok,
  });

  factory SingleUserSocialMediaLinks.fromJson(Map<String, dynamic> json) {
    return SingleUserSocialMediaLinks(
      instagram: json['instagram'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      youtube: json['youtube'],
      tiktok: json['tiktok'],
    );
  }
}
