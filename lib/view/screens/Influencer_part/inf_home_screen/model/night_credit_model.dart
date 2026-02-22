class GiftsResponse {
  final bool success;
  final String message;
  final GiftsData data;

  GiftsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GiftsResponse.fromJson(Map<String, dynamic> json) {
    return GiftsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GiftsData.fromJson(json['data'] ?? {}),
    );
  }
}

class GiftsData {
  final GiftUser user;
  final List<GiftItem> gifts;
  final GiftSummary summary;

  GiftsData({
    required this.user,
    required this.gifts,
    required this.summary,
  });

  factory GiftsData.fromJson(Map<String, dynamic> json) {
    return GiftsData(
      user: GiftUser.fromJson(json['user'] ?? {}),
      gifts: (json['gifts'] as List? ?? [])
          .map((e) => GiftItem.fromJson(e))
          .toList(),
      summary: GiftSummary.fromJson(json['summary'] ?? {}),
    );
  }
}

class GiftUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final int totalReviews;
  final String status;

  GiftUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.totalReviews,
    required this.status,
  });

  factory GiftUser.fromJson(Map<String, dynamic> json) {
    return GiftUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      totalReviews: json['totalReviews'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class GiftItem {
  final String type;
  final String giftId;
  final String collaborationId;
  final String collaborationTitle;
  final int starsReceived;
  final CollaborationDetails collaborationDetails;
  final Participants participants;
  final GiftFrom giftFrom;
  final DateTime? receivedAt;

  GiftItem({
    required this.type,
    required this.giftId,
    required this.collaborationId,
    required this.collaborationTitle,
    required this.starsReceived,
    required this.collaborationDetails,
    required this.participants,
    required this.giftFrom,
    this.receivedAt,
  });

  factory GiftItem.fromJson(Map<String, dynamic> json) {
    return GiftItem(
      type: json['type'] ?? '',
      giftId: json['giftId'] ?? '',
      collaborationId: json['collaborationId'] ?? '',
      collaborationTitle: json['collaborationTitle'] ?? '',
      starsReceived: json['starsReceived'] ?? 0,
      collaborationDetails:
      CollaborationDetails.fromJson(json['collaborationDetails'] ?? {}),
      participants:
      Participants.fromJson(json['participants'] ?? {}),
      giftFrom: GiftFrom.fromJson(json['giftFrom'] ?? {}),
      receivedAt: json['receivedAt'] != null
          ? DateTime.tryParse(json['receivedAt'])
          : null,
    );
  }
}

class CollaborationDetails {
  final String title;
  final String description;
  final String status;
  final String negotiationStatus;
  final String paymentStatus;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;
  final DateTime? completedAt;

  CollaborationDetails({
    required this.title,
    required this.description,
    required this.status,
    required this.negotiationStatus,
    required this.paymentStatus,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.completedAt,
  });

  factory CollaborationDetails.fromJson(Map<String, dynamic> json) {
    return CollaborationDetails(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      negotiationStatus: json['negotiationStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'])
          : null,
    );
  }
}

class Participants {
  final SimpleUser creator;
  final SimpleUser partner;

  Participants({
    required this.creator,
    required this.partner,
  });

  factory Participants.fromJson(Map<String, dynamic> json) {
    return Participants(
      creator: SimpleUser.fromJson(json['creator'] ?? {}),
      partner: SimpleUser.fromJson(json['partner'] ?? {}),
    );
  }
}

class SimpleUser {
  final String id;
  final String name;
  final String email;
  final String role;

  SimpleUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class GiftFrom {
  final String id;
  final String name;
  final String email;
  final String role;

  GiftFrom({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory GiftFrom.fromJson(Map<String, dynamic> json) {
    return GiftFrom(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class GiftSummary {
  final int totalGifts;
  final int totalGiftStars;
  final int averageStarsPerGift;

  GiftSummary({
    required this.totalGifts,
    required this.totalGiftStars,
    required this.averageStarsPerGift,
  });

  factory GiftSummary.fromJson(Map<String, dynamic> json) {
    return GiftSummary(
      totalGifts: json['totalGifts'] ?? 0,
      totalGiftStars: json['totalGiftStars'] ?? 0,
      averageStarsPerGift: json['averageStarsPerGift'] ?? 0,
    );
  }
}


class GiftSource {
  final String giftId;
  final String collaborationId;
  final String collaborationTitle;
  final int starsReceived;
  final DateTime? receivedDate;
  final String giftFrom;

  GiftSource({
    required this.giftId,
    required this.collaborationId,
    required this.collaborationTitle,
    required this.starsReceived,
    this.receivedDate,
    required this.giftFrom,
  });

  factory GiftSource.fromJson(Map<String, dynamic> json) {
    return GiftSource(
      giftId: json['giftId'] ?? '',
      collaborationId: json['collaborationId'] ?? '',
      collaborationTitle: json['collaborationTitle'] ?? '',
      starsReceived: json['starsReceived'] ?? 0,
      receivedDate: json['receivedDate'] != null
          ? DateTime.tryParse(json['receivedDate'])
          : null,
      giftFrom: json['giftFrom'] ?? '',
    );
  }
}