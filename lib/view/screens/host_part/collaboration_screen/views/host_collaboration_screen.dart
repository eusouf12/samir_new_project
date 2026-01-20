import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/collabration_controller.dart';
import '../model/collaboration_model.dart';
import '../widget/custom_collaboration_card.dart';

class HostCollaborationScreen extends StatelessWidget {
  HostCollaborationScreen({super.key});

  final CollaborationController controller = Get.put(CollaborationController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMyCollaborations();
    });

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true,titleName: "My Collaborations",),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Manage Requests",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                bottom: 8,
              ),
              CustomText(
                text:
                "Review requests from influencers who want to collaborate on your listings.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textClr,
                textAlign: TextAlign.start,
                maxLines: 3,
                bottom: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "15",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: "Total",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "3",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffEAB308),
                      ),
                      CustomText(
                        text: "Pending",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "9",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff22C55E),
                      ),
                      CustomText(
                        text: "Approved",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "9",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffEF4444),
                      ),
                      CustomText(
                        text: "Declined",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // ========== Custom TabBar ==========
              Obx(() => CustomTabBar(
                tabs: controller.collaborationTabList,
                selectedIndex: controller.currentIndex.value,
                onTabSelected: controller.onTabSelected,
                selectedColor: AppColors.primary,
              )),

              SizedBox(height: 10.h),

              // ========== Collaboration List ==========
              Expanded(
                child: Obx(() {
                  if (controller.rxCollaborationStatus.value == Status.loading && controller.collaborationList.isEmpty) {
                    return const Center(child: CustomLoader());
                  }
                  if (controller.rxCollaborationStatus.value == Status.error && controller.collaborationList.isEmpty) {
                    return Center(
                      child: Text("Failed to load collaborations", style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !controller.isCollaborationLoadMore.value) {
                        controller.getMyCollaborations(loadMore: true);
                      }
                      return false;
                    },
                    child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.collaborationList.length,
                  itemBuilder: (context, index) {
                  final collaboration = controller.collaborationList[index];

                  return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomCollaborationCard(
                  profileImage: AppConstants.girlsPhoto,
                  userName: collaboration.deal.id ?? "Unknown",
                  userHandle:  "@unknown",
                  //tags: collaboration. ?? ["General"],
                  location:  "Unknown Location",

                  // ===== Dynamic Callbacks =====
                  onViewDetailsTap: () {
                 // print("View Details tapped for ${collaboration.userName}");
                  // Example: Navigate to detail screen
                  // Get.toNamed(AppRoutes.collaborationDetails, arguments: collaboration);
                  },
                  onApproveTap: () {
                 //; print("Approve tapped for ${collaboration.userName}");
                  // Example: Call approve API
                  // controller.approveCollaboration(collaboration.id);
                  },
                  onDeclineTap: () {
                 // print("Decline tapped for ${collaboration.userName}");
                  // Example: Call decline API
                  // controller.declineCollaboration(collaboration.id);
                  },
                  ),
                  );
                  },
                  )
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

