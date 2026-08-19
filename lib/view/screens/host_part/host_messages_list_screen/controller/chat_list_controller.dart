import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../model/chat_list_model.dart';

import '../../../../../service/block_service.dart';

class ChatListController extends GetxController {
  RxList<ConversationModel> conversationList = <ConversationModel>[].obs;

  final isLoading = false.obs;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> getConversations({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= totalPages) return;
      currentPage++;
    } else {
      currentPage = 1;
      conversationList.clear();
      isLoading.value = true;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getChatList(page: currentPage.toString()));

      if (response.statusCode == 200) {
        final data =
        ConversationListResponse.fromJson(response.body);

        totalPages = data.data.pagination.totalPages;

        final blockService = BlockService.to;
        final filtered = data.data.conversations.where((conv) {
          return !conv.participants.any((p) => blockService.isBlocked(p.id));
        }).toList();

        conversationList.addAll(filtered);
      }
    } catch (e) {
      debugPrint('❌ Conversation API Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  // ==================== GetCheckPreviousListExist =================
  RxList<ConversationModel> chatExistList = <ConversationModel>[].obs;

  final isChatExistLoading = false.obs;

  Future<String?> checkChatListExist({
    required String id,
  }) async {
    try {
      final response =
      await ApiClient.getData(ApiUrl.checkChatList(id: id));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.body is String ? jsonDecode(response.body): Map<String, dynamic>.from(response.body);

        final data = body['data'];
        if (data != null && data['conversationId'] != null) {
          return data['conversationId'].toString();
        }
      }
    } catch (e) {
      debugPrint('❌ Conversation API Error: $e');
    }

    return null;
  }

}
