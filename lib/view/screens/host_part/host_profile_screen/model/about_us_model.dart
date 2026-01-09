class AboutUsModel {
  final bool success;
  final String message;
  final List<LegalDocumentAboutModel> data;

  AboutUsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => LegalDocumentAboutModel.fromJson(e))
          .toList(),
    );
  }
}


class LegalDocumentAboutModel {
  final String description;

  LegalDocumentAboutModel({required this.description});

  factory LegalDocumentAboutModel.fromJson(Map<String, dynamic> json) {
    final List dataList = json['data'] ?? [];

    if (dataList.isEmpty) {
      return LegalDocumentAboutModel(description: '');
    }

    return LegalDocumentAboutModel(
      description: dataList.first['description'] ?? '',
    );
  }
}

