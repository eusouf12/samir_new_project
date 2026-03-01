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

class CalenderScreen extends StatelessWidget {
  CalenderScreen({super.key});
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
              ],
            ),
          );
        }),
        bottomNavigationBar: InfNavbar(currentIndex: 1),
      ),
    );
  }
}
