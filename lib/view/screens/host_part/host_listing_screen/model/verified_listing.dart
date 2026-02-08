
class VerifiedListingsResponse {
  final bool success;
  final bool error;
  final String message;
  final VerifiedListingsData data;

  VerifiedListingsResponse({
    required this.success,
    required this.error,
    required this.message,
    required this.data,
  });

  factory VerifiedListingsResponse.fromJson(Map<String, dynamic> json) {
    return VerifiedListingsResponse(
      success: json['success'] ?? false,
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      data: VerifiedListingsData.fromJson(json['data'] ?? {}),
    );
  }
}

class VerifiedListingsData {
  final Pagination pagination;
  final ListingsMeta meta;
  final List<VerifiedListingItem> listings;

  VerifiedListingsData({
    required this.pagination,
    required this.meta,
    required this.listings,
  });

  factory VerifiedListingsData.fromJson(Map<String, dynamic> json) {
    return VerifiedListingsData(
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      meta: ListingsMeta.fromJson(json['meta'] ?? {}),
      listings: (json['listings'] as List? ?? [])
          .map((e) => VerifiedListingItem.fromJson(e))
          .toList(),
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int total;
  final int limit;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}


class ListingsMeta {
  final int totalVerifiedListings;
  final int totalListings;
  final String verificationRate;

  ListingsMeta({
    required this.totalVerifiedListings,
    required this.totalListings,
    required this.verificationRate,
  });

  factory ListingsMeta.fromJson(Map<String, dynamic> json) {
    return ListingsMeta(
      totalVerifiedListings: json['totalVerifiedListings'] ?? 0,
      totalListings: json['totalListings'] ?? 0,
      verificationRate: json['verificationRate'] ?? '0',
    );
  }
}


class VerifiedListingItem {
  final String id;
  final String? rejectionReason;
  final String title;
  final String description;
  final String location;
  final String addAirbnbLink;
  final String propertyType;
  final Map<String, bool> amenities;
  final List<String> images;
  final List<String> customAmenities;
  final String status;
  final String userId;
  final String createdAt;
  final String updatedAt;

  VerifiedListingItem({
    required this.id,
    this.rejectionReason,
    required this.title,
    required this.description,
    required this.location,
    required this.addAirbnbLink,
    required this.propertyType,
    required this.amenities,
    required this.images,
    required this.customAmenities,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VerifiedListingItem.fromJson(Map<String, dynamic> json) {
    return VerifiedListingItem(
      id: json['_id'] ?? '',
      rejectionReason: json['rejectionReason'] as String?,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      addAirbnbLink: json['addAirbnbLink'] ?? '',
      propertyType: json['propertyType'] ?? '',
      amenities: Map<String, bool>.from(json['amenities'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      customAmenities: List<String>.from(json['customAmenities'] ?? []),
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
