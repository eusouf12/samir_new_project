import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/controller/message_controller.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getChatMessages(id: "695986d3fe849e7776429832");
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: const [
              CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jhonson",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text("Active Now",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
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

            /// ================== MESSAGE LIST ==================
            Expanded(
              child: Obx(() {
                //=========== INITIAL LOADER ===========
                if (controller.rxStatus.value == Status.loading && controller.messageList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                //=========== EMPTY ===========
                if (controller.messageList.isEmpty &&
                    controller.messages.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chat_bubble_outline,
                          size: 80, color: Color(0xFF4DB6AC)),
                      SizedBox(height: 15),
                      Text("Start your message",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  );
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                        controller.rxStatus.value != Status.loading &&
                        controller.hasMore) {
                      controller.getChatMessages(
                        loadMore: true,
                        id: "conversationId",
                      );
                    }
                    return false;
                  },

                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount:
                    controller.messageList.length +
                        controller.messages.length +
                        (controller.hasMore ? 1 : 0),

                    itemBuilder: (_, index) {
                      /// ====== PAGINATION LOADER ======
                      if (index == controller.messageList.length + controller.messages.length) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      }

                      /// ====== LOCAL MESSAGE ======
                      if (index < controller.messages.length) {
                        return ChatBubble(msg: controller.messages[index]);
                      }

                      /// ====== BACKEND MESSAGE ======
                      final msg = controller.messageList[
                      index - controller.messages.length];

                      return ChatBubble(msg: {
                        "type": msg.imageUrl.isNotEmpty ? "image" : "text",
                        "content": msg.imageUrl.isNotEmpty
                            ? "${ApiUrl.baseUrl}/${msg.imageUrl.first}"
                          : msg.text,
                        "isMe": false,
                      });
                    },
                  ),
                );
              }),
            ),

            /// ================== INPUT ==================
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
                        Border.all(color: const Color(0xFF4DB6AC)),
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
                            icon: const Icon(Icons.image_outlined,
                                color: Color(0xFF4DB6AC)),
                            onPressed:
                            controller.pickImagesFromGallery,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF4DB6AC)),
                      ),
                      child: const Icon(Icons.send_outlined,
                          color: Color(0xFF4DB6AC)),
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
  const ChatBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    bool isMe = msg['isMe'];
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          if (msg['type'] == 'image') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenImage(imagePath: msg['content'])));
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: msg['type'] == 'text' ? EdgeInsets.all(10) : EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isMe ? Color(0xFF4DB6AC) : Colors.grey[300],
            borderRadius: BorderRadius.circular(msg['type'] == 'text' ? 5 : 25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (msg['type'] == 'image')
                Hero(
                  tag: msg['content'],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildImage(msg['content']),
                  ),
                )
              else
                Text(
                  msg['content'],
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
            ],
          ),

        ),
      ),
    );
  }
  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    } else {
      return Image.file(
        File(path),
        width: 200,
        fit: BoxFit.cover,
      );
    }
  }

}

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white)),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: PhotoView(
            imageProvider: FileImage(File(imagePath)),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          ),
        ),
      ),
    );
  }
}