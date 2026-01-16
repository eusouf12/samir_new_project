import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/inbox_model.dart';

class MessageController extends GetxController {
  //================ TEXT ==================
  final TextEditingController messageController = TextEditingController();

  //================ LOCAL CHAT (UI only) ==================
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  //================ IMAGE PICKER ==================
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImagesFromGallery() async {
    final List<XFile>? images = await _imagePicker.pickMultiImage(
      imageQuality: 80,
    );

    if (images != null && images.isNotEmpty) {
      for (var img in images) {
        messages.add({
          "type": "image",
          "content": img.path,
          "isMe": true,
          "time": "10:45 AM",
        });
      }
    }
  }

  //================ SEND TEXT ==================
  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add({
      "type": "text",
      "content": text,
      "isMe": true,
      "time": "10:40 AM",
    });

    messageController.clear();
  }

  //================ API CHAT ==================
  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;

  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<Pagination?> pagination = Rx<Pagination?>(null);

  int currentPage = 1;
  bool hasMore = true;

  Future<void> getChatMessages({
    bool loadMore = false,
    required String id,
  }) async {
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
      final response = await ApiClient.getData(ApiUrl.getChatMessages(id: id, page: currentPage.toString(),),);

      if (response.statusCode == 200) {
        final model = ChatListResponse.fromJson(response.body);

        messageList.addAll(model.data.messages);

        pagination.value = model.data.pagination;

        hasMore =
            model.data.pagination.currentPage <
                model.data.pagination.totalPages;

        setStatus(Status.completed);
      } else {
        setStatus(Status.error);
      }
    } catch (e) {
      setStatus(Status.error);
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
