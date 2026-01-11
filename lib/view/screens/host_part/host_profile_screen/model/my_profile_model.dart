class UserResponse {
  final bool success;
  final UserData data;

  UserResponse({
    required this.success,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      data: UserData.fromJson(json['data']),
    );
  }
}
class UserData {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String dateOfBirth;
  final String phone;
  final String role;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool airbnbAccountLinked;
  final int avgResponseTime;
  final List<dynamic> collaborations;
  final int collaborationsTotal;
  final List<dynamic> completeDeals;
  final int completeDealsTotal;
  final List<dynamic> deals;
  final int dealsTotal;
  final List<String> listings;
  final int listingsTotal;
  final List<dynamic> nicheTags;
  final int responseRate;
  final String fullAddress;
  final String image;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.phone,
    required this.dateOfBirth,
    required this.role,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.airbnbAccountLinked,
    required this.avgResponseTime,
    required this.collaborations,
    required this.collaborationsTotal,
    required this.completeDeals,
    required this.completeDealsTotal,
    required this.deals,
    required this.dealsTotal,
    required this.listings,
    required this.listingsTotal,
    required this.nicheTags,
    required this.responseRate,
    required this.fullAddress,
    required this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
      airbnbAccountLinked: json['airbnbAccountLinked'] ?? false,
      avgResponseTime: json['avgResponseTime'] ?? 0,
      collaborations: List<dynamic>.from(json['collaborations'] ?? []),
      collaborationsTotal: json['collaborationsTotal'] ?? 0,
      completeDeals: List<dynamic>.from(json['completeDeals'] ?? []),
      completeDealsTotal: json['completeDealsTotal'] ?? 0,
      deals: List<dynamic>.from(json['deals'] ?? []),
      dealsTotal: json['dealsTotal'] ?? 0,
      listings: List<String>.from(json['listings'] ?? []),
      listingsTotal: json['listingsTotal'] ?? 0,
      nicheTags: List<dynamic>.from(json['nicheTags'] ?? []),
      responseRate: json['responseRate'] ?? 0,
      fullAddress: json['fullAddress'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
