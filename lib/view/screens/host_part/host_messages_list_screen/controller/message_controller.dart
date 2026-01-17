import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/controller/chat_list_controller.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../service/socket_service.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../host_profile_screen/controller/host_profile_controller.dart';
import '../model/inbox_model.dart';

class MessageController extends GetxController {
  //================ TEXT ==================
  final TextEditingController messageController = TextEditingController();
  final HostProfileController profileController = Get.put(HostProfileController());
  final ChatListController chatListController = Get.put(ChatListController());

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    listenMessage();
  }

  // ================== LISTEN SOCKET MESSAGE ==================
  void listenMessage() {
    SocketApi.on('single-chat-message', (data) {
      debugPrint("📩 New Message Received: $data");

      // ডাটা ফরম্যাট অনুযায়ী ম্যাপ করে লিস্টে অ্যাড করা
      // মনে রাখবেন, সার্ভার থেকে আসা 'text' বা 'message' কী (key) চেক করে নিবেন
      Map<String, dynamic> incomingMsg = {
        "isMe": false, // যেহেতু অন্য কেউ পাঠিয়েছে
        "text": data['text'] ?? data['message'] ?? "",
        "imageUrl": data['imageUrl'] ?? [],
        "createdAt": DateTime.now(),
      };

      // UI তে মেসেজ দেখানোর জন্য messages লিস্টে অ্যাড করা
      messages.insert(0, incomingMsg);
    });
  }

  // ================== SEND TEXT VIA SOCKET ==================
  Future<void> sendMessage({required String receiverId}) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final body = {
      "receiverId": receiverId,
      "text": text,
    };

    // 1️⃣ socket emit
    SocketApi.emit('single-chat-send-message', body);
    chatListController.getConversations();

    // 2️⃣ local message add
    messages.insert(0, {
      "isMe": true,
      "text": text,
      "imageUrl": <String>[],
      "createdAt": DateTime.now(),
    });

    // 3️⃣ clear input
    messageController.clear();
  }


  // ================== PICK IMAGE ==================
  Future<void> pickImagesFromGallery() async {
    final List<XFile>? images = await _imagePicker.pickMultiImage(imageQuality: 80);

    if (images != null && images.isNotEmpty) {
      // ইমেজ পাঠানোর জন্য আপনার সার্ভারে আলাদা ইভেন্ট থাকতে পারে
      // আপাতত লোকালি দেখাচ্ছি
      messages.insert(0, {
        "isMe": true,
        "text": "",
        "imageUrl": images.map((e) => e.path).toList(),
        "createdAt": DateTime.now(),
      });
    }
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
    }
    else {
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

        hasMore = model.data.pagination.currentPage < model.data.pagination.totalPages;
        await chatListController.getConversations();

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
