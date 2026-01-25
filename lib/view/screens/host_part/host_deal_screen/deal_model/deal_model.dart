import 'dart:convert';

class DealResponse {
  final bool success;
  final bool error;
  final String message;
  final int totalPages;
  final int currentPage;
  final int limit;
  final int total;
  final List<Deal> deals;

  DealResponse({
    required this.success,
    required this.error,
    required this.message,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
    required this.total,
    required this.deals,
  });

  factory DealResponse.fromJson(Map<String, dynamic> json) {
    final dealsJson = json['data']?['deals'] as List<dynamic>? ?? [];
    return DealResponse(
      success: json['success'] ?? false,
      error: json['error'] ?? false,
      message: json['message'] ?? "",
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      deals: dealsJson.map((e) => Deal.fromJson(e)).toList(),
    );
  }
}

class Deal {
  final String id;
  final String description;
  final String addAirbnbLink;
  final DateTime inTimeAndDate;
  final DateTime outTimeAndDate;
  final int guestCount;
  final String status;
  final Compensation compensation;
  final PropertyTitle title;
  final List<Deliverable> deliverables;
  final UserInfo userId;

  Deal({
    required this.id,
    required this.description,
    required this.addAirbnbLink,
    required this.inTimeAndDate,
    required this.outTimeAndDate,
    required this.guestCount,
    required this.status,
    required this.compensation,
    required this.title,
    required this.deliverables,
    required this.userId,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    final deliverablesJson = json['deliverables'] as List<dynamic>? ?? [];
    return Deal(
      id: json['_id'] ?? "",
      description: json['description'] ?? "",
      addAirbnbLink: json['addAirbnbLink'] ?? "",
      inTimeAndDate: json['inTimeAndDate'] != null
          ? DateTime.parse(json['inTimeAndDate'])
          : DateTime.now(),
      outTimeAndDate: json['outTimeAndDate'] != null
          ? DateTime.parse(json['outTimeAndDate'])
          : DateTime.now(),
      guestCount: json['guestCount'] ?? 0,
      status: json['status'] ?? "",
      compensation: Compensation.fromJson(json['compensation'] ?? {}),
      title: PropertyTitle.fromJson(json['title'] ?? {}),
      deliverables: deliverablesJson.map((e) => Deliverable.fromJson(e)).toList(),
      userId: UserInfo.fromJson(json['userId'] ?? {}),
    );
  }
}

class Compensation {
  final bool nightCredits;
  final int numberOfNights;
  final bool directPayment;
  final String? paymentAmount;

  Compensation({
    required this.nightCredits,
    required this.numberOfNights,
    required this.directPayment,
    this.paymentAmount,
  });

  factory Compensation.fromJson(Map<String, dynamic> json) {
    return Compensation(
      nightCredits: json['nightCredits'] ?? false,
      numberOfNights: json['numberOfNights'] ?? 0,
      directPayment: json['directPayment'] ?? false,
      paymentAmount: json['paymentAmount']?.toString(),
    );
  }
}

class PropertyTitle {
  final String id;
  final String title;
  final String location;
  final List<String> images;

  PropertyTitle({
    required this.id,
    required this.title,
    required this.location,
    required this.images,
  });

  factory PropertyTitle.fromJson(Map<String, dynamic> json) {
    return PropertyTitle(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      location: json['location'] ?? "",
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class Deliverable {
  final String platform;
  final String contentType;
  final int quantity;

  Deliverable({
    required this.platform,
    required this.contentType,
    required this.quantity,
  });

  factory Deliverable.fromJson(Map<String, dynamic> json) {
    return Deliverable(
      platform: json['platform'] ?? "",
      contentType: json['contentType'] ?? "",
      quantity: json['quantity'] ?? 0,
    );
  }
}

class UserInfo {
  final String id;
  final String name;
  final String email;
  final String image;
  final String? userName;

  UserInfo({
    required this.id,
    required this.name,
    this.userName,
    required this.email,
    required this.image,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      userName: json['userName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
