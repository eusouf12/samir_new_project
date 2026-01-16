class ChatListResponse {
  final bool success;
  final String message;
  final ChatData data;

  ChatListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ChatData.fromJson(json['data'] ?? {}),
    );
  }
}
class ChatData {
  final List<MessageModel> messages;
  final Pagination pagination;

  ChatData({
    required this.messages,
    required this.pagination,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((e) => MessageModel.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}
class MessageModel {
  final String id;
  final String text;
  final List<String> imageUrl;
  final String? audioUrl;
  final bool seen;
  final UserModel msgByUser;
  final String conversationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.text,
    required this.imageUrl,
    this.audioUrl,
    required this.seen,
    required this.msgByUser,
    required this.conversationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      text: json['text'] ?? '',
      imageUrl: (json['imageUrl'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      audioUrl: json['audioUrl'],
      seen: json['seen'] ?? false,
      msgByUser: UserModel.fromJson(json['msgByUserId'] ?? {}),
      conversationId: json['conversationId'] ?? '',
      createdAt:
      DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
      DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image']??'',
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalMessages;
  final int messagesPerPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalMessages,
    required this.messagesPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalMessages: json['totalMessages'] ?? 0,
      messagesPerPage: json['messagesPerPage'] ?? 10,
    );
  }
}

