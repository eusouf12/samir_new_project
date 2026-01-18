class MyCollaborationsResponse {
  final bool success;
  final bool error;
  final String message;
  final int totalPages;
  final int currentPage;
  final int total;
  final CollaborationData data;

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
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      total: json['total'] ?? 0,
      data: CollaborationData.fromJson(json['data'] ?? {}),
    );
  }
}


class CollaborationData {
  final List<CollaborationModel> collaborations;

  CollaborationData({required this.collaborations});

  factory CollaborationData.fromJson(Map<String, dynamic> json) {
    return CollaborationData(
      collaborations: (json['collaborations'] as List<dynamic>? ?? [])
          .map((e) => CollaborationModel.fromJson(e))
          .toList(),
    );
  }
}


class CollaborationModel {
  final String id;
  final UserMini userId;
  final UserMini selectInfluencerOrHost;
  final DealModel selectDeal;
  final String status;
  final String negotiationStatus;
  final String paymentStatus;
  final String rejectReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  final bool canAccept;
  final bool canReject;
  final bool canNegotiate;
  final bool canWithdraw;

  final String role;

  // optional fields (completed deal এ থাকে)
  final String? payment;
  final bool? freeStay;
  final int? numberOfNights;
  final DateTime? startDate;
  final DateTime? endDate;

  CollaborationModel({
    required this.id,
    required this.userId,
    required this.selectInfluencerOrHost,
    required this.selectDeal,
    required this.status,
    required this.negotiationStatus,
    required this.paymentStatus,
    required this.rejectReason,
    required this.createdAt,
    required this.updatedAt,
    required this.canAccept,
    required this.canReject,
    required this.canNegotiate,
    required this.canWithdraw,
    required this.role,
    this.payment,
    this.freeStay,
    this.numberOfNights,
    this.startDate,
    this.endDate,
  });

  factory CollaborationModel.fromJson(Map<String, dynamic> json) {
    return CollaborationModel(
      id: json['_id'] ?? '',
      userId: UserMini.fromJson(json['userId'] ?? {}),
      selectInfluencerOrHost:
      UserMini.fromJson(json['selectInfluencerOrHost'] ?? {}),
      selectDeal: DealModel.fromJson(json['selectDeal'] ?? {}),
      status: json['status'] ?? '',
      negotiationStatus: json['negotiationStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      rejectReason: json['rejectReason'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      canAccept: json['canAccept'] ?? false,
      canReject: json['canReject'] ?? false,
      canNegotiate: json['canNegotiate'] ?? false,
      canWithdraw: json['canWithdraw'] ?? false,
      role: json['role'] ?? '',
      payment: json['payment'],
      freeStay: json['freeStay'],
      numberOfNights: json['numberOfNights'],
      startDate:
      json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate:
      json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }
}

class UserMini {
  final String id;
  final String name;
  final String email;
  final String role;

  UserMini({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserMini.fromJson(Map<String, dynamic> json) {
    return UserMini(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class DealModel {
  final String id;
  final String dealTitle;
  final String description;
  final String addAirbnbLink;
  final String inTimeAndDate;
  final String outTimeAndDate;
  final String status;
  final Compensation compensation;

  DealModel({
    required this.id,
    required this.dealTitle,
    required this.description,
    required this.addAirbnbLink,
    required this.inTimeAndDate,
    required this.outTimeAndDate,
    required this.status,
    required this.compensation,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['_id'] ?? '',
      dealTitle: json['dealTitle'] ?? '',
      description: json['description'] ?? '',
      addAirbnbLink: json['addAirbnbLink'] ?? '',
      inTimeAndDate: json['inTimeAndDate'] ?? '',
      outTimeAndDate: json['outTimeAndDate'] ?? '',
      status: json['status'] ?? '',
      compensation: Compensation.fromJson(json['compensation'] ?? {}),
    );
  }
}

class Compensation {
  final bool nightCredits;
  final int numberOfNights;
  final bool directPayment;
  final String paymentAmount;

  Compensation({
    required this.nightCredits,
    required this.numberOfNights,
    required this.directPayment,
    required this.paymentAmount,
  });

  factory Compensation.fromJson(Map<String, dynamic> json) {
    return Compensation(
      nightCredits: json['nightCredits'] ?? false,
      numberOfNights: json['numberOfNights'] ?? 0,
      directPayment: json['directPayment'] ?? false,
      paymentAmount: json['paymentAmount']?.toString() ?? '',
    );
  }
}
