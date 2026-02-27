import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/screens/Influencer_part/inf_home_screen/widgets/custom_inf_home_card.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_nav_bar/inf_navbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../host_part/collaboration_screen/controller/collabration_controller.dart';
import '../../../host_part/host_active_influe/controller/influencer_list_host_controller.dart';
import '../../../host_part/host_home_screen/controller/notification_controller.dart';
import '../../../host_part/host_home_screen/widgets/custom_activity_card.dart';

class InfHomeScreen extends StatelessWidget {
  InfHomeScreen({super.key});
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());
  final NotificationController notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      String id = await SharePrefsHelper.getString(AppConstants.userId);
      collaborationController.getSingleUser(userId: id);
      influencerListHostController.getInfluencers();
      notificationController.getNotifications();
    });
    return CustomGradient(
      child: Scaffold(
        body:Obx((){
          if (collaborationController.rxGetSingleUserStatus.value == Status.loading) {
            return  Center(child: CustomLoader(color: AppColors.primary2));
          }

          if (collaborationController.singleUserProfile.value == null) {
            return const Center(child: CustomText(text: "Profile not found", fontSize: 16,),);
          }
          final userData = collaborationController.singleUserProfile;
          return Padding(
          padding: const EdgeInsets.only(top: 60, right: 20.0, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Welcome! ${userData.value?.name}",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "Here's your overview .",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.hostNotificationScreen,arguments: userData.value?.role);
                    },
                    child: CustomImage(imageSrc: AppIcons.notifacationLoadIcon),
                  ),
                ],
              ),
              //Body
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInfHomeCard(
                    onTap: (){
                      Get.toNamed(AppRoutes.infNightCreditsScreen);
                    },
                  ),
                  CustomInfHomeCard(
                    image: AppIcons.revenueIcon,
                    title: "\$247",
                    subtitle: "Revenue",
                    onTap: () {
                      Get.toNamed(AppRoutes.infEarningsScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              //collaboration and Active host
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInfHomeCard(
                    image: AppIcons.dealsIcons,
                    title: "${userData.value?.collaborationStats?.total}",
                    subtitle: "Total\n Collaboration",
                    onTap: () {
                      Get.toNamed(AppRoutes.hostCollaborationScreen,arguments: userData.value?.role ?? ""
                      );
                    },
                  ),
                  //host
                  CustomInfHomeCard(
                    image: AppIcons.activeHostIcon,
                    title: influencerListHostController.influencerList.length.toString(),
                    subtitle: "Active Host",
                    onTap: () {
                      debugPrint("myNightCredits : ${userData.value?.nightCredits}");
                      Get.toNamed(AppRoutes.hostActiveInflue ,
                          arguments: { "role" : collaborationController.singleUserProfile.value?.role, "myNightCredits" : userData.value?.nightCredits}
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Recent Activity", fontSize: 18, fontWeight: FontWeight.w600, bottom: 20,),
                    Expanded(
                      child: Obx(() {

                        if (notificationController.isNotificationLoading.value) {
                          return  Center(child: CustomLoader(color: AppColors.primary2,));
                        }

                        final firstFour = notificationController.notificationList.take(4).toList();

                        if (firstFour.isEmpty) {return const Center(child: CustomText(text: "No activity found"),);
                        }

                        return ListView.builder(
                          itemCount: firstFour.length,
                          itemBuilder: (context, index) {
                            final item = firstFour[index];
                            return Padding(padding: const EdgeInsets.only(bottom: 10),
                              child: CustomActivityCard(
                                icon: AppIcons.collaboraIcon,
                                message: item.message ?? "",
                                title: item.title ?? "",
                                time: _timeAgo(item.createdAt),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
        }),
        bottomNavigationBar: InfNavbar(currentIndex: 0),
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
