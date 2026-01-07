import 'dart:convert';

/// ================== ROOT RESPONSE ==================
class ListingsResponse {
  final bool success;
  final bool error;
  final String message;
  final int totalPages;
  final int currentPage;
  final int total;
  final ListingsData data;

  ListingsResponse({
    required this.success,
    required this.error,
    required this.message,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.data,
  });

  factory ListingsResponse.fromJson(Map<String, dynamic> json) {
    return ListingsResponse(
      success: json['success'] ?? false,
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      total: json['total'] ?? 0,
      data: ListingsData.fromJson(json['data'] ?? {}),
    );
  }
}

/// ================== DATA ==================
class ListingsData {
  final List<ListingItem> listings;

  ListingsData({required this.listings});

  factory ListingsData.fromJson(Map<String, dynamic> json) {
    return ListingsData(
      listings: (json['listings'] as List<dynamic>? ?? [])
          .map((e) => ListingItem.fromJson(e))
          .toList(),
    );
  }
}

/// ================== LISTING ITEM ==================
class ListingItem {
  final String id;
  final String title;
  final String description;
  final String location;
  final String propertyType;
  final Map<String, bool> amenities;
  final List<String> images;
  final List<String> customAmenities;
  final String status;
  final ListingUser user;
  final String createdAt;
  final String updatedAt;

  ListingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.propertyType,
    required this.amenities,
    required this.images,
    required this.customAmenities,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListingItem.fromJson(Map<String, dynamic> json) {
    return ListingItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      propertyType: json['propertyType'] ?? '',
      amenities: Map<String, bool>.from(json['amenities'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      customAmenities: _parseCustomAmenities(json['customAmenities']),
      status: json['status'] ?? '',
      user: ListingUser.fromJson(json['userId'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  /// 🔥 FIX for backend stringified array issue
  static List<String> _parseCustomAmenities(dynamic data) {
    if (data == null || data.isEmpty) return [];

    try {
      if (data.first is String && data.first.toString().startsWith('[')) {
        return List<String>.from(jsonDecode(data.first));
      }
      return List<String>.from(data);
    } catch (_) {
      return [];
    }
  }
}

/// ================== USER ==================
class ListingUser {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String role;
  final bool airbnbAccountLinked;
  final int responseRate;
  final int listingsTotal;

  ListingUser({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.role,
    required this.airbnbAccountLinked,
    required this.responseRate,
    required this.listingsTotal,
  });

  factory ListingUser.fromJson(Map<String, dynamic> json) {
    return ListingUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      role: json['role'] ?? '',
      airbnbAccountLinked: json['airbnbAccountLinked'] ?? false,
      responseRate: json['responseRate'] ?? 0,
      listingsTotal: json['listingsTotal'] ?? 0,
    );
  }
}
