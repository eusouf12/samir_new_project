import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/inbox_model.dart';

class MessageController extends GetxController {
  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;

  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<Pagination?> pagination = Rx<Pagination?>(null);

  int currentPage = 1;
  bool hasMore = true;

  // Get InBOX CHAT Messages
  Future<void> getChatMessages({bool loadMore = false,required String id}) async {
    //String id = await SharePrefsHelper.getString(AppConstants.userId);
    if (loadMore && !hasMore) return;

    if (loadMore) {
      currentPage++;
    } else {
      currentPage = 1;
      messageList.clear();
      hasMore = true;
      setStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getChatMessages(id: id, page: currentPage.toString()));

      if (response.statusCode == 200) {
        final model = ChatListResponse.fromJson(response.body);

        messageList.addAll(model.data.messages);

        pagination.value = model.data.pagination;

        hasMore = model.data.pagination.currentPage <
            model.data.pagination.totalPages;

        setStatus(Status.completed);
      } else {
        setStatus(Status.error);
      }
    } catch (e) {
      setStatus(Status.error);
    }
  }
}
