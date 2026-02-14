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
  final List<SingleUserDeliverable>? deliverables;
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
    this.deliverables,
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
      userId: json['userId'] != null ? SingleUserInfo.fromJson(json['userId']) : null,
      selectInfluencerOrHost: json['selectInfluencerOrHost'] != null ? SingleUserInfo.fromJson(json['selectInfluencerOrHost']) : null,
      selectDeal: json['selectDeal'] != null ? SingleUserDealInfo.fromJson(json['selectDeal']) : null,
      deliverables: (json['deliverables'] as List?)?.map((e) => SingleUserDeliverable.fromJson(e)).toList(),
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
  final String? userName;
  final String? email;
  final String? role;
  final String? fullAddress;
  final String? image;
  final List<InfluencerSocialMedia>? socialMediaLinks;

  SingleUserInfo({
    this.id,
    this.name,
    this.userName,
    this.email,
    this.role,
    this.fullAddress,
    this.image,
    this.socialMediaLinks,
  });

  factory SingleUserInfo.fromJson(Map<String, dynamic> json) {
    return SingleUserInfo(
      id: json['_id'],
      name: json['name'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      fullAddress: json['fullAddress'],
      image: json['image'],
      socialMediaLinks: (json['socialMediaLinks'] as List?)
          ?.map((e) => InfluencerSocialMedia.fromJson(e))
          .toList(),
    );
  }
}


class InfluencerSocialMedia {
  final String? platform;
  final String? url;
  final String? followers;

  InfluencerSocialMedia({
    this.platform,
    this.url,
    this.followers,
  });

  factory InfluencerSocialMedia.fromJson(Map<String, dynamic> json) {
    return InfluencerSocialMedia(
      platform: json['platform'],
      url: json['url'],
      followers: json['followers'],
    );
  }
}

class SingleUserDealInfo {
  final String? id;
  final SingleUserCompensation? compensation;
  final SingleUserDealTitle? title;
  final String? description;
  final String? addAirbnbLink;
  final String? inTimeAndDate;
  final String? outTimeAndDate;
  final int? guestCount;
  final String? status;


  SingleUserDealInfo({
    this.id,
    this.compensation,
    this.title,
    this.description,
    this.addAirbnbLink,
    this.inTimeAndDate,
    this.outTimeAndDate,
    this.guestCount,
    this.status,
  });

  factory SingleUserDealInfo.fromJson(Map<String, dynamic> json) {
    return SingleUserDealInfo(
      id: json['_id'],
      compensation: json['compensation'] != null ? SingleUserCompensation.fromJson(json['compensation']) : null,
      title: json['title'] != null ? SingleUserDealTitle.fromJson(json['title']) : null,
      description: json['description'],
      addAirbnbLink: json['addAirbnbLink'],
      inTimeAndDate: json['inTimeAndDate'],
      outTimeAndDate: json['outTimeAndDate'],
      guestCount: json['guestCount'],
      status: json['status'],
    );
  }
}

class SingleUserAmenities {
  final bool wifi;
  final bool kitchen;
  final bool tv;
  final bool pool;
  final bool airConditioning;
  final bool gym;
  final bool parking;
  final bool petFriendly;
  final bool hotTub;

  SingleUserAmenities({
    required this.wifi,
    required this.kitchen,
    required this.tv,
    required this.pool,
    required this.airConditioning,
    required this.gym,
    required this.parking,
    required this.petFriendly,
    required this.hotTub,
  });

  factory SingleUserAmenities.fromJson(Map<String, dynamic> json) {
    return SingleUserAmenities(
      wifi: json['wifi'] ?? false,
      kitchen: json['kitchen'] ?? false,
      tv: json['tv'] ?? false,
      pool: json['pool'] ?? false,
      airConditioning: json['airConditioning'] ?? false,
      gym: json['gym'] ?? false,
      parking: json['parking'] ?? false,
      petFriendly: json['petFriendly'] ?? false,
      hotTub: json['hotTub'] ?? false,
    );
  }
}

class SingleUserCompensation {
  final bool? nightCredits;
  final int? numberOfNights;
  final String? paymentAmount;
  final bool? directPayment;

  SingleUserCompensation({
    this.nightCredits,
    this.numberOfNights,
    this.paymentAmount,
    this.directPayment,
  });

  factory SingleUserCompensation.fromJson(Map<String, dynamic> json) {
    return SingleUserCompensation(
      nightCredits: json['nightCredits'],
      numberOfNights: json['numberOfNights'],
      paymentAmount: json['paymentAmount'],
      directPayment: json['directPayment'],
    );
  }
}

class SingleUserDealTitle {
  final String? id;
  final String? title;
  final String? location;
  final List<String>? images;
  final SingleUserAmenities? amenities;

  SingleUserDealTitle({
    this.id,
    this.title,
    this.location,
    this.images,
    this.amenities,
  });

  factory SingleUserDealTitle.fromJson(Map<String, dynamic> json) {
    return SingleUserDealTitle(
      id: json['_id'],
      title: json['title'],
      location: json['location'],
      images: (json['images'] as List?)?.cast<String>(),
      amenities: json['amenities'] != null ? SingleUserAmenities.fromJson(json['amenities']) : null,
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
  final List<SocialPost>? instagram;
  final List<SocialPost>? facebook;
  final List<SocialPost>? twitter;
  final List<SocialPost>? youtube;
  final List<SocialPost>? tiktok;

  SingleUserSocialMediaLinks({
    this.instagram,
    this.facebook,
    this.twitter,
    this.youtube,
    this.tiktok,
  });

  factory SingleUserSocialMediaLinks.fromJson(Map<String, dynamic> json) {
    return SingleUserSocialMediaLinks(
      instagram: (json['instagram'] as List?)
          ?.where((e) => e is Map<String, dynamic>)
          .map((e) => SocialPost.fromJson(e))
          .toList(),

      facebook: (json['facebook'] as List?)
          ?.where((e) => e is Map<String, dynamic>)
          .map((e) => SocialPost.fromJson(e))
          .toList(),

      twitter: (json['twitter'] as List?)
          ?.where((e) => e is Map<String, dynamic>)
          .map((e) => SocialPost.fromJson(e))
          .toList(),

      youtube: (json['youtube'] as List?)
          ?.where((e) => e is Map<String, dynamic>)
          .map((e) => SocialPost.fromJson(e))
          .toList(),

      tiktok: (json['tiktok'] as List?)
          ?.where((e) => e is Map<String, dynamic>)
          .map((e) => SocialPost.fromJson(e))
          .toList(),
    );
  }
}

class SocialPost {
  final String? id;
  final String? url;
  final String? contentType;
  final String? postDate;

  SocialPost({
    this.id,
    this.url,
    this.contentType,
    this.postDate,
  });

  factory SocialPost.fromJson(Map<String, dynamic> json) {
    return SocialPost(
      id: json['_id'],
      url: json['url'],
      contentType: json['contentType'],
      postDate: json['postDate'],
    );
  }
}



