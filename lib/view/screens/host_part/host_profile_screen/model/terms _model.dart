class LegalDocumentModel {
  final String content;
  final String description;

  LegalDocumentModel({
    required this.content,
    required this.description,
  });

  factory LegalDocumentModel.fromJson(Map<String, dynamic> json) {
    return LegalDocumentModel(
      content: json['content'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class LegalDocumentResponse {
  final bool success;
  final String message;
  final List<LegalDocumentModel> data;

  LegalDocumentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LegalDocumentResponse.fromJson(Map<String, dynamic> json) {
    return LegalDocumentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => LegalDocumentModel.fromJson(e))
          .toList(),
    );
  }
}
