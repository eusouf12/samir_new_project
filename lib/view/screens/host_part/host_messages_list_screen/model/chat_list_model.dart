class ConversationListResponse {
  final bool success;
  final String message;
  final ConversationData data;

  ConversationListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ConversationListResponse.fromJson(Map<String, dynamic> json) {
    return ConversationListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ConversationData.fromJson(json['data'] ?? {}),
    );
  }
}
class ConversationData {
  final List<ConversationModel> conversations;
  final Pagination pagination;

  ConversationData({
    required this.conversations,
    required this.pagination,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversations: (json['conversations'] as List? ?? [])
          .map((e) => ConversationModel.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}
class ConversationModel {
  final String id;
  final List<Participant> participants;
  final LastMessage? lastMessage;
  final bool isDelete;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConversationModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'] ?? '',
      participants: (json['participants'] as List? ?? [])
          .map((e) => Participant.fromJson(e))
          .toList(),
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      isDelete: json['isDelete'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class Participant {
  final String id;
  final String name;
  final String email;
  final String? image;

  Participant({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}


class LastMessage {
  final String id;
  final String text;
  final List<String> imageUrl;
  final String audioUrl;
  final bool seen;
  final String msgByUserId;
  final String conversationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LastMessage({
    required this.id,
    required this.text,
    required this.imageUrl,
    required this.audioUrl,
    required this.seen,
    required this.msgByUserId,
    required this.conversationId,
    this.createdAt,
    this.updatedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id'] ?? '',
      text: json['text'] ?? '',
      imageUrl: List<String>.from(json['imageUrl'] ?? []),
      audioUrl: json['audioUrl'] ?? '',
      seen: json['seen'] ?? false,
      msgByUserId: json['msgByUserId'] ?? '',
      conversationId: json['conversationId'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalConversations;
  final int conversationsPerPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalConversations,
    required this.conversationsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalConversations: json['totalConversations'] ?? 0,
      conversationsPerPage: json['conversationsPerPage'] ?? 10,
    );
  }
}
