import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/service/api_url.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/widgets/custom_message_card.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../controller/chat_list_controller.dart';
import 'chat_inbox_screen.dart';

class HostMessagesListScreen extends StatelessWidget {
  HostMessagesListScreen({super.key});

  final ChatListController controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getConversations(loadMore: false);
    });

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Messages",),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() {
            //========= Loader =========
            if (controller.isLoading.value && controller.conversationList.isEmpty) {
              return const Center(child: CustomLoader());
            }

            if (controller.conversationList.isEmpty) {
              return const Center(child: CustomText(text: "No conversations found", fontSize: 16,),);
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !controller.isLoading.value) {controller.getConversations(loadMore: true);}
                return false;
              },

              child: ListView.builder(
                itemCount: controller.conversationList.length + (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.conversationList.length) {
                    final conversation = controller.conversationList[index];
                    final user = conversation.participants[1];
                    return GestureDetector(
                      onTap: (){
                        debugPrint("${conversation.id}");
                        debugPrint("${user.name}");
                        debugPrint("${user.image}");
                        debugPrint("${user.id}");
                        Get.toNamed(AppRoutes.chatScreen,
                          arguments: {
                            'conversationId': conversation.id,
                            'userName': user.name,
                            'userImage': user.image,
                            'receiverId': user.id,
                          },
                        );
                      },
                      child: CustomMessageCard(
                        profileImage: ApiUrl.baseUrl + "${user.image}" ?? '',
                        name: user.name ?? '',
                        lastMessage: conversation.lastMessage?.text ?? '',
                        time: conversation.createdAt,
                      ),
                    );
                  }

                  /// ========= Pagination Loader =========
                  return const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(child: CustomLoader()),
                  );
                },
              ),
            );
          }),
        ),

        bottomNavigationBar: HostNavbar(currentIndex: 1),
      ),
    );
  }
}

