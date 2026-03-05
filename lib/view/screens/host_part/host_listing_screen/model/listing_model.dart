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
/// ================== LISTING ITEM (Fixed) ==================
class ListingItem {
  final String id;
  final String? rejectionReason;
  final String title;
  final String description;
  final String addAirbnbLink;
  final String location;
  final String propertyType;
  final Map<String, bool> amenities;
  final List<String> images;
  final List<String> customAmenities;
  final String status;
  final ListingUser user;
  final String createdAt;
  final String updatedAt;
  final bool isFavorite; //

  ListingItem({
    required this.id,
    this.rejectionReason,
    required this.title,
    required this.description,
    required this.addAirbnbLink,
    required this.location,
    required this.propertyType,
    required this.amenities,
    required this.images,
    required this.customAmenities,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false, //
  });

  // copyWith মেথড যা আপনার কন্ট্রোলারে ব্যবহৃত হবে
  ListingItem copyWith({
    String? id,
    String? rejectionReason,
    String? title,
    String? description,
    String? addAirbnbLink,
    String? location,
    String? propertyType,
    Map<String, bool>? amenities,
    List<String>? images,
    List<String>? customAmenities,
    String? status,
    ListingUser? user,
    String? createdAt,
    String? updatedAt,
    bool? isFavorite,
  }) {
    return ListingItem(
      id: id ?? this.id,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      title: title ?? this.title,
      description: description ?? this.description,
      addAirbnbLink: addAirbnbLink ?? this.addAirbnbLink,
      location: location ?? this.location,
      propertyType: propertyType ?? this.propertyType,
      amenities: amenities ?? this.amenities,
      images: images ?? this.images,
      customAmenities: customAmenities ?? this.customAmenities,
      status: status ?? this.status,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // এই একটি মাত্র factory কনস্ট্রাক্টর রাখুন
  factory ListingItem.fromJson(Map<String, dynamic> json) {
    return ListingItem(
      id: json['_id'] ?? '',
      rejectionReason: json['rejectionReason'] as String?,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      addAirbnbLink: json['addAirbnbLink'] ?? '',
      location: json['location'] ?? '',
      propertyType: json['propertyType'] ?? '',
      amenities: Map<String, bool>.from(json['amenities'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      customAmenities: _parseCustomAmenities(json['customAmenities']),
      status: json['status'] ?? '',
      user: ListingUser.fromJson(json['userId'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  static List<String> _parseCustomAmenities(dynamic data) {
    if (data == null) return [];
    if (data is List) return data.map((e) => e.toString()).toList();
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is List) return decoded.map((e) => e.toString()).toList();
      } catch (_) {}
    }
    return [];
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
