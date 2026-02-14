class UserReviewResponse {
  final bool success;
  final String message;
  final ReviewData data;

  UserReviewResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserReviewResponse.fromJson(Map<String, dynamic> json) {
    return UserReviewResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ReviewData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class ReviewData {
  final ReviewPagination pagination;
  final ReviewMeta meta;
  final List<ReviewModel> reviews;

  ReviewData({
    required this.pagination,
    required this.meta,
    required this.reviews,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      pagination: ReviewPagination.fromJson(json['pagination'] ?? {}),
      meta: ReviewMeta.fromJson(json['meta'] ?? {}),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
    "meta": meta.toJson(),
    "reviews": reviews.map((e) => e.toJson()).toList(),
  };
}

class ReviewPagination {
  final int currentPage;
  final int totalPages;
  final int total;
  final int limit;

  ReviewPagination({
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.limit,
  });

  factory ReviewPagination.fromJson(Map<String, dynamic> json) {
    return ReviewPagination(
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "total": total,
    "limit": limit,
  };
}


class ReviewMeta {
  final String userId;
  final int reviewsWritten;
  final int reviewsReceived;
  final double averageRating;
  final FilterApplied filterApplied;

  ReviewMeta({
    required this.userId,
    required this.reviewsWritten,
    required this.reviewsReceived,
    required this.averageRating,
    required this.filterApplied,
  });

  factory ReviewMeta.fromJson(Map<String, dynamic> json) {
    return ReviewMeta(
      userId: json['userId'] ?? '',
      reviewsWritten: json['reviewsWritten'] ?? 0,
      reviewsReceived: json['reviewsReceived'] ?? 0,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      filterApplied:
      FilterApplied.fromJson(json['filterApplied'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "reviewsWritten": reviewsWritten,
    "reviewsReceived": reviewsReceived,
    "averageRating": averageRating,
    "filterApplied": filterApplied.toJson(),
  };
}


class FilterApplied {
  final String? reviewType;

  FilterApplied({this.reviewType});

  factory FilterApplied.fromJson(Map<String, dynamic> json) {
    return FilterApplied(
      reviewType: json['reviewType'],
    );
  }

  Map<String, dynamic> toJson() => {
    "reviewType": reviewType,
  };
}


class ReviewModel {
  final String id;
  final int rating;
  final String comment;
  final String reviewType;
  final bool isDeleted;
  final DateTime createdAt;
  final Reviewer reviewer;
  final Reviewer reviewee;

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.reviewType,
    required this.isDeleted,
    required this.createdAt,
    required this.reviewer,
    required this.reviewee,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      reviewType: json['reviewType'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      reviewer: Reviewer.fromJson(json['reviewerId'] ?? {}),
      reviewee: Reviewer.fromJson(json['revieweeId'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rating": rating,
    "comment": comment,
    "reviewType": reviewType,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "reviewerId": reviewer.toJson(),
    "revieweeId": reviewee.toJson(),
  };
}

class Reviewer {
  final String id;
  final String name;
  final String email;
  final String image;

  Reviewer({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "image": image,
  };
}

