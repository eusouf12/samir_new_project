import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';

import '../widgets/delete_dialog.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImagesFromGallery() async {
    final List<XFile>? images = await _imagePicker.pickMultiImage(
      imageQuality: 80, // image size reduce
    );

    if (images != null && images.isNotEmpty) {
      for (var img in images) {
        setState(() {
          messages.add({
            "type": "image",
            "content": img.path,
            "isMe": true,
            "time": "10:45 AM",
          });
        });
      }
    }
  }



  void sendMessage() {
    if (_messageController.text
        .trim()
        .isNotEmpty) {
      setState(() {
        messages.add({
          "type": "text",
          "content": _messageController.text,
          "isMe": true,
          "time": "10:40 AM",
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jhonson", style: TextStyle(color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
                  Text("Active Now",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          // 
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz, color: Colors.black),
              onSelected: (value) {
                if (value == 'delete') {
                  showDeleteDialog(
                    context: context,
                    onDelete: () {
                      // controller.messages.clear();
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    height: 30,
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 15),
                        SizedBox(width: 5),
                        Text('Delete Conversation',
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Divider(thickness: 1, color: Colors.grey[300]),
            Expanded(
              child: messages.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80,
                      color: Color(0xFF4DB6AC)),
                  SizedBox(height: 15),
                  Text("Start your message",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    ChatBubble(msg: messages[index]),
              ),
            ),
            //============ send text field =================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFF4DB6AC)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Type something...",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                                Icons.image_outlined, color: Color(0xFF4DB6AC)),
                            onPressed: () {
                              pickImagesFromGallery();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF4DB6AC)),
                      ),
                      child: Icon(Icons.send_outlined, color: Color(0xFF4DB6AC),
                          size: 24),
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
  ChatBubble({required this.msg});

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
                    child: Image.file(File(msg['content']), width: 200, fit: BoxFit.cover),
                  ),
                )
              else if (msg['type'] == 'text')
                Text(msg['content'], style: TextStyle(color: isMe ? Colors.white : Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  FullScreenImage({required this.imagePath});

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