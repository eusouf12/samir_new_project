class NotificationResponse {
  final bool? success;
  final bool? error;
  final String? message;
  final NotificationData? data;

  NotificationResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'],
      error: json['error'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationData.fromJson(json['data'])
          : null,
    );
  }
}

class NotificationData {
  final Pagination? pagination;
  final List<AppNotification>? notifications;

  NotificationData({
    this.pagination,
    this.notifications,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      notifications: json['notifications'] != null
          ? List<AppNotification>.from(
          json['notifications']
              .map((x) => AppNotification.fromJson(x)))
          : [],
    );
  }
}

class Pagination {
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? limit;

  Pagination({
    this.totalPages,
    this.currentPage,
    this.total,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      total: json['total'],
      limit: json['limit'],
    );
  }
}

class AppNotification {
  final String? id;
  final String? type;
  final String? title;
  final String? message;
  final CollaborationId? collaborationId;
  final Receiver? receiverId;
  final String? receiverRole;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppNotification({
    this.id,
    this.type,
    this.title,
    this.message,
    this.collaborationId,
    this.receiverId,
    this.receiverRole,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['_id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      collaborationId: json['collaborationId'] != null
          ? CollaborationId.fromJson(json['collaborationId'])
          : null,
      receiverId: json['receiverId'] != null
          ? Receiver.fromJson(json['receiverId'])
          : null,
      receiverRole: json['receiverRole'],
      isRead: json['isRead'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

class CollaborationId {
  final String? id;
  final dynamic selectDeal;

  CollaborationId({
    this.id,
    this.selectDeal,
  });

  factory CollaborationId.fromJson(Map<String, dynamic> json) {
    return CollaborationId(
      id: json['_id'],
      selectDeal: json['selectDeal'],
    );
  }
}

class Receiver {
  final String? id;
  final String? name;
  final String? email;

  Receiver({
    this.id,
    this.name,
    this.email,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}