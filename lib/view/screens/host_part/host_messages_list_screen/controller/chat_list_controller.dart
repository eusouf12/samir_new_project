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

  /// 🔥 Get Conversation List API
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
}
