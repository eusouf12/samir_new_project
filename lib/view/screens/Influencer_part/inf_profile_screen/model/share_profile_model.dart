class ShareableLinkResponse {
  final bool success;
  final String message;
  final ShareableData data;

  ShareableLinkResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ShareableLinkResponse.fromJson(Map<String, dynamic> json) {
    return ShareableLinkResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ShareableData.fromJson(json['data'] ?? {}),
    );
  }
}

class ShareableData {
  final ShareableLinks shareableLinks;
  final String username;
  final Platforms platforms;

  ShareableData({
    required this.shareableLinks,
    required this.username,
    required this.platforms,
  });

  factory ShareableData.fromJson(Map<String, dynamic> json) {
    return ShareableData(
      shareableLinks: ShareableLinks.fromJson(json['shareableLinks'] ?? {}),
      username: json['username'] ?? '',
      platforms: Platforms.fromJson(json['platforms'] ?? {}),
    );
  }
}

class ShareableLinks {
  final String web;
  final String mobile;
  final String universal;

  ShareableLinks({
    required this.web,
    required this.mobile,
    required this.universal,
  });

  factory ShareableLinks.fromJson(Map<String, dynamic> json) {
    return ShareableLinks(
      web: json['web'] ?? '',
      mobile: json['mobile'] ?? '',
      universal: json['universal'] ?? '',
    );
  }
}

class Platforms {
  final String web;
  final String mobile;
  final String universal;

  Platforms({
    required this.web,
    required this.mobile,
    required this.universal,
  });

  factory Platforms.fromJson(Map<String, dynamic> json) {
    return Platforms(
      web: json['web'] ?? '',
      mobile: json['mobile'] ?? '',
      universal: json['universal'] ?? '',
    );
  }
}