import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../model/chat_list_model.dart';

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

        conversationList.addAll(data.data.conversations);
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
        final body = response.body;

        final messages = body['data']['messages'];

        if (messages != null && messages.isNotEmpty) {
          return messages.first['conversationId'];
        }
      }
    } catch (e) {
      debugPrint('❌ Conversation API Error: $e');
    }

    return null;
  }

}
