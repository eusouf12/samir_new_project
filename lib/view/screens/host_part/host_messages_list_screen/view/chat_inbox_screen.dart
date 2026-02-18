import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/controller/chat_list_controller.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/controller/message_controller.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../host_profile_screen/controller/host_profile_controller.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final MessageController controller = Get.put(MessageController());
  final HostProfileController  profileController= Get.put(HostProfileController());
  final ChatListController  chatListController= Get.put(ChatListController());
  final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String conversationId = args['conversationId'] ?? "";
    final String userName = args['userName'] ?? "";
    final String? userImage = args['userImage'] as String?;
    final String receiverId = args['receiverId'] ?? "";
    final String role = args['role'] ;
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      controller.getChatMessages(id: conversationId);
      profileController.getUserProfile();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () async{
              await chatListController.getConversations();
            Get.back();
            },
          ),
          title: Row(
            children:  [
              CircleAvatar(
                backgroundImage: (userImage != null && userImage.isNotEmpty)
                    ? NetworkImage("${ApiUrl.baseUrl}$userImage") : NetworkImage("${AppConstants.profileImage2}"),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( userName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  //Text("Active Now", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: Colors.black),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red, size: 15),
                      SizedBox(width: 5),
                      Text('Delete Conversation',
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),

        body: Column(
          children: [
            Divider(thickness: 1, color: Colors.grey[300]),
            Expanded(
              child: Obx(() {
                //===========  Loader===========
                if (controller.rxStatus.value == Status.loading && controller.messageList.isEmpty) {
                  return const Center(child: CustomLoader());
                }

                //=========== Empty ===========
                if (controller.messageList.isEmpty && controller.messages.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.chat_bubble_outline, size: 80, color: role == "host" ? Color(0xFF4DB6AC) : AppColors.primary2),
                      SizedBox(height: 15),
                      Text("Start your message", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  );
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && controller.rxStatus.value != Status.loading && controller.hasMore) {
                      controller.getChatMessages(loadMore: true, id: conversationId,);
                    }
                    return false;
                  },

                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: controller.messageList.length + controller.messages.length + (controller.hasMore ? 1 : 0),

                    itemBuilder: (_, index) {
                      if (index == controller.messageList.length + controller.messages.length) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(child: CustomLoader()),
                        );
                      }

                      if (index < controller.messages.length) {
                        return ChatBubble(msg: controller.messages[controller.messages.length - 1 - index]);
                      }

                      final msgIndex = index - controller.messages.length;
                      final msg = controller.messageList[msgIndex];

                      return ChatBubble(
                        msg: {
                          "isMe": msg.msgByUser.id == profileController.userData.value?.id,
                          "text": msg.text,
                          "imageUrl": msg.imageUrl,
                          "createdAt": msg.createdAt,
                        },
                      );
                    },
                  ),
                );
              }),
            ),

            // ================== INPUT ==================
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                        Border.all(color:role == "host" ? AppColors.primary : AppColors.primary2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.messageController,
                              decoration: const InputDecoration(
                                hintText: "Type something...",
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.image_outlined,
                                color: role == "host" ? AppColors.primary : AppColors.primary2),
                            onPressed:
                            controller.pickImagesFromGallery,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage(receiverId: receiverId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: role == "host" ? AppColors.primary : AppColors.primary2),
                      ),
                      child:  Icon(Icons.send_outlined, color: role == "host" ? AppColors.primary : AppColors.primary2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChatBubble extends StatelessWidget {
  final Map<String, dynamic> msg;
  ChatBubble({super.key, required this.msg});
  final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final bool isMe = msg['isMe'] ?? false;
    final String text = msg['text'] ?? '';
    final List images = msg['imageUrl'] ?? [];
    final DateTime? time = msg['createdAt'];
    final String role = args['role'] ;

    return Column(
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Bubble
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: images.isEmpty ? const EdgeInsets.all(10) : const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isMe ? role == "host" ? AppColors.primary : AppColors.primary2 : Colors.grey[300],
              borderRadius: BorderRadius.circular(images.isEmpty ? 5 : 23),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (images.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: images.map<Widget>((img) {
                      final imagePath = img.toString();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FullScreenImage(imagePath: imagePath),
                            ),
                          );
                        },
                        child: Hero(
                          tag: imagePath,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _buildImage(context, imagePath),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                if (text.trim().isNotEmpty && images.isNotEmpty)
                  const SizedBox(height: 6),

                if (text.trim().isNotEmpty)
                  Padding(
                    padding: images.isNotEmpty
                        ? const EdgeInsets.all(10)
                        : EdgeInsets.zero,
                    child: CustomText(
                      text: text,
                      color: isMe ? Colors.white : Colors.black,
                      maxLines: 100,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // TIME
        if (time != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment:
              isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                DateFormat('hh:mm a').format(time.toLocal()),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );

  }

  Widget _buildImage(BuildContext context, String path) {
    //==== local cash image
    if (path.startsWith('/data') || path.startsWith('/storage')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(path),
          width: MediaQuery.sizeOf(context).width * 0.7,
          height: 150,
          fit: BoxFit.cover,
        ),
      );
    }

    // ==== backend img
    final fullUrl = path.startsWith('http') ? path : "${ApiUrl.baseUrl}$path";

    return CustomNetworkImage(
      imageUrl: fullUrl,
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 150,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );
  }

}

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final bool isLocal =
        imagePath.startsWith('/data') || imagePath.startsWith('/storage');

    final ImageProvider imageProvider = isLocal
        ? FileImage(File(imagePath))
        : NetworkImage(
      imagePath.startsWith('http')
          ? imagePath
          : "${ApiUrl.baseUrl}$imagePath",
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: PhotoView(
            imageProvider: imageProvider,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration:
            const BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
