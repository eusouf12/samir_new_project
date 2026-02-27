import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import 'controller/notification_controller.dart';
import 'model/notification_model.dart';

class HostNotificationScreen extends StatelessWidget {
  HostNotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());
  final ScrollController scrollController = ScrollController();
  final role = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      controller.getNotifications();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        controller.getNotifications(loadMore: true);
      }
    });

    return Scaffold(
      appBar:CustomRoyelAppbar(titleName: "Notifications",leftIcon: true,),
      body:

      Obx(() {

        if (controller.isNotificationLoading.value) {
          return Center(
            child: CustomLoader(color: role == "host" ? AppColors.primary : AppColors.primary2,),
          );
        }

        if (controller.notificationList.isEmpty) {
          return const Center(child: Text("No notifications found"),);
        }

        return Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const CustomText(
                    text: "",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  GestureDetector(
                    onTap: () {
                     // controller.markAllAsRead();
                    },
                    child: CustomText(
                      text: "Read All",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: role == "host" ? AppColors.primary : AppColors.primary2,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount:
                controller.notificationList.length + 1,
                itemBuilder: (context, index) {

                  if (index ==
                      controller.notificationList.length) {
                    return Obx(() =>
                    controller
                        .isNotificationLoadMoreLoading
                        .value
                        ? Padding(
                      padding:
                      const EdgeInsets.all(16),
                      child: Center(
                        child: CustomLoader(
                          color: role == "host"
                              ? AppColors.primary
                              : AppColors.primary2,
                        ),
                      ),
                    )
                        : const SizedBox.shrink());
                  }

                  final item =
                  controller.notificationList[index];

                  return _notificationCard(item);
                },
              ),
            ),
          ],
        );
      })
    );
  }

  Widget _notificationCard(AppNotification item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.isRead == true ? Colors.white : const Color(0xffF5F9FF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          CustomText(text:item.title ?? "",fontSize: 14, color: Colors.black,fontWeight: FontWeight.w600,),
          const SizedBox(height: 6),
          CustomText(text:item.message ?? "",fontSize: 13, color: Colors.grey),
          const SizedBox(height: 8),
          CustomText(text: _timeAgo(item.createdAt),fontSize: 11, color: Colors.black),
        ],
      ),
    );
  }

  String _timeAgo(DateTime? dateTime) {
    if (dateTime == null) return "";

    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }
}
