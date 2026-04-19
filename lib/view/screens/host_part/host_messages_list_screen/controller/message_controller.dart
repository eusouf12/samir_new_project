// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/controller/chat_list_controller.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../service/permission.dart';
import '../../../../../service/socket_service.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
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
      Map<String, dynamic> incomingMsg = {
        "isMe": false,
        "text": data['text'] ?? data['message'] ?? "",
        "imageUrl": data['imageUrl'] ?? [],
        "createdAt": DateTime.now(),
      };
      messages.insert(0, incomingMsg);
    });
  }

  // ================== SEND TEXT VIA SOCKET ==================
  Future<void> sendMessage({required String receiverId}) async {
    final text = messageController.text.trim();
    if (selectedImages.isNotEmpty) {
      postImageSend(receiverId: receiverId, images: selectedImages);
      selectedImages.clear();
      messageController.clear();
    }

    else if (text.isNotEmpty) {
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
    messageController.clear();
     }
  }
  // ================== PICK IMAGE ==================
  RxList<XFile> selectedImages = <XFile>[].obs;
  Future<void> pickImagesFromGallery() async {
    if (await PermissionHelper.checkGalleryPermission()) {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedImages = await picker.pickMultiImage();

      if (pickedImages.isNotEmpty) {
        selectedImages.addAll(pickedImages);
      }
    }
  }
  //========== send pic ==================

  Future<void> postImageSend({required String receiverId, required List<XFile> images,}) async {
    try {
      List<MultipartBody> multipartImages = [];

      for (var xFile in images) {
        multipartImages.add(
          MultipartBody(
            'images',
            File(xFile.path),
          ),
        );
      }

      final body = {"text": messageController.text.trim()};

      final response = await ApiClient.postMultipartData(ApiUrl.sendImage(id: receiverId), body, multipartBody: multipartImages,);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = response.body is String ? jsonDecode(response.body) : response.body;

        final messageData = res['data']?['data']?['message'];

        if (messageData == null) {debugPrint("Message data null");
          return;
        }

        final List imageList = messageData['imageUrl'] ?? [];

        final List<String> imageUrls = imageList.map<String>((e) => ApiUrl.baseUrl + e['url'].toString()).toList();

        messages.insert(0, {
          "isMe": true,
          "text": messageData['text'] ?? "",
          "imageUrl": imageUrls,
          "createdAt":
          DateTime.parse(messageData['createdAt']),
        });
        chatListController.getConversations();
        messageController.clear();

      } else {showCustomSnackBar("Image send failed", isError: true);
      }
    } catch (e) {
      debugPrint("Image Send Error: $e");
      showCustomSnackBar("Something went wrong", isError: true);
    }
  }



  //================ API CHAT ==================
  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<OtherParticipant?> otherParticipant = Rx<OtherParticipant?>(null);
  Rx<Pagination?> pagination = Rx<Pagination?>(null);
  int currentPage = 1;
  bool hasMore = true;

  Future<void> getChatMessages({bool loadMore = false, required String id,}) async {
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
        otherParticipant.value = model.data.otherParticipant;

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
