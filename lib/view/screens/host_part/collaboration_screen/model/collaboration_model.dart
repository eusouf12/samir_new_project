class MyCollaborationsResponse {
  final bool success;
  final bool error;
  final String message;
  final int totalPages;
  final int currentPage;
  final int total;
  final CollaborationsData data;

  MyCollaborationsResponse({
    required this.success,
    required this.error,
    required this.message,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.data,
  });

  factory MyCollaborationsResponse.fromJson(Map<String, dynamic> json) {
    return MyCollaborationsResponse(
      success: json['success'] ?? false,
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      totalPages: json['totalPages'] is int
          ? json['totalPages']
          : int.tryParse(json['totalPages'].toString()) ?? 1,
      currentPage: json['currentPage'] is int
          ? json['currentPage']
          : int.tryParse(json['currentPage'].toString()) ?? 1, // String "1" কে int এ কনভার্ট করবে
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total'].toString()) ?? 0,
      data: CollaborationsData.fromJson(json['data'] ?? {}),
    );
  }
}

class CollaborationsData {
  final List<CollaborationModel> collaborations;

  CollaborationsData({required this.collaborations});

  factory CollaborationsData.fromJson(Map<String, dynamic> json) {
    return CollaborationsData(collaborations: (json['collaborations'] as List<dynamic>? ?? []).map((e) => CollaborationModel.fromJson(e)).toList(),
    );
  }
}

class CollaborationModel {
  final String id;
  final SocialMediaLinks socialMediaLinks;
  final UserShortInfo user;
  final UserShortInfo influencer;
  final CollaborationDealModel deal;
  final String status;
  final String negotiationStatus;
  final String paymentStatus;
  final String rejectReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool canAccept;
  final bool canReject;
  final bool canNegotiate;
  final bool canWithdraw;
  final String role;

  CollaborationModel({
    required this.id,
    required this.socialMediaLinks,
    required this.user,
    required this.influencer,
    required this.deal,
    required this.status,
    required this.negotiationStatus,
    required this.paymentStatus,
    required this.rejectReason,
    this.createdAt,
    this.updatedAt,
    required this.canAccept,
    required this.canReject,
    required this.canNegotiate,
    required this.canWithdraw,
    required this.role,
  });

  factory CollaborationModel.fromJson(Map<String, dynamic> json) {
    return CollaborationModel(
      id: json['_id'] ?? '',
      socialMediaLinks:
      SocialMediaLinks.fromJson(json['socialMediaLinks'] ?? {}),
      user: UserShortInfo.fromJson(json['userId'] ?? {}),
      influencer:
      UserShortInfo.fromJson(json['selectInfluencerOrHost'] ?? {}),
      deal: CollaborationDealModel.fromJson(json['selectDeal'] ?? {}),
      status: json['status'] ?? '',
      negotiationStatus: json['negotiationStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      rejectReason: json['rejectReason'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      canAccept: json['canAccept'] ?? false,
      canReject: json['canReject'] ?? false,
      canNegotiate: json['canNegotiate'] ?? false,
      canWithdraw: json['canWithdraw'] ?? false,
      role: json['role'] ?? '',
    );
  }
}

class SocialMediaLinks {
  final String instagram;
  final String facebook;
  final String twitter;
  final String youtube;
  final String tiktok;

  SocialMediaLinks({
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.youtube,
    required this.tiktok,
  });

  factory SocialMediaLinks.fromJson(Map<String, dynamic> json) {
    return SocialMediaLinks(
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
      twitter: json['twitter'] ?? '',
      youtube: json['youtube'] ?? '',
      tiktok: json['tiktok'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
      'youtube': youtube,
      'tiktok': tiktok,
    };
  }
}

class UserShortInfo {
  final String id;
  final String name;
  final String email;
  final String role;

  UserShortInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserShortInfo.fromJson(Map<String, dynamic> json) {
    return UserShortInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class CollaborationDealModel {
  final String id;
  final String description;
  final String addAirbnbLink;
  final DateTime? inTime;
  final DateTime? outTime;
  final int guestCount;
  final String status;
  final CompensationModel compensation;

  CollaborationDealModel({
    required this.id,
    required this.description,
    required this.addAirbnbLink,
    this.inTime,
    this.outTime,
    required this.guestCount,
    required this.status,
    required this.compensation,
  });

  factory CollaborationDealModel.fromJson(Map<String, dynamic> json) {
    return CollaborationDealModel(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      addAirbnbLink: json['addAirbnbLink'] ?? '',
      inTime: DateTime.tryParse(json['inTimeAndDate'] ?? ''),
      outTime: DateTime.tryParse(json['outTimeAndDate'] ?? ''),
      guestCount: json['guestCount'] ?? 0,
      status: json['status'] ?? '',
      compensation:
      CompensationModel.fromJson(json['compensation'] ?? {}),
    );
  }
}

class CompensationModel {
  final bool nightCredits;
  final int numberOfNights;
  final bool directPayment;
  final String? paymentAmount;

  CompensationModel({
    required this.nightCredits,
    required this.numberOfNights,
    required this.directPayment,
    this.paymentAmount,
  });

  factory CompensationModel.fromJson(Map<String, dynamic> json) {
    return CompensationModel(
      nightCredits: json['nightCredits'] ?? false,
      numberOfNights: json['numberOfNights'] ?? 0,
      directPayment: json['directPayment'] ?? false,
      paymentAmount: json['paymentAmount']?.toString(),
    );
  }
}
