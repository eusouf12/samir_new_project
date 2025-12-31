import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_deals_container.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_tab_selected/custom_tab_selected.dart';
import 'controller/host_home_controller.dart';

class HostDealsScreen extends StatelessWidget {
  HostDealsScreen({super.key});
  final HostHomeController hostHomeController = Get.find<HostHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // search field
            CustomTextField(
              fieldBorderColor: AppColors.primary,
              fillColor: AppColors.white,
              isDens: true,
              hintText: "Search deals by name or partner",
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: AppColors.textClr,
              ),
              hintStyle: TextStyle(color: AppColors.textClr),
            ),
            SizedBox(height: 16),
            Obx(
                  () => CustomTabSelector(
                tabs: hostHomeController.tabNames,
                countNum: "5",
                selectedIndex: hostHomeController.selectedTab.value,
                selectedColor: AppColors.primary,
                unselectedColor: Colors.black,
                onTabSelected: hostHomeController.changeTab,
              ),
            ),
            SizedBox(height: 10.h),
            // deals list
            Obx(
                  () {
                int tab = hostHomeController.selectedTab.value;
                if (tab == 0) {
                  // All Tab
                  return Expanded(
                    child: ListView(
                      children: List.generate(10, (index) => CustomDealsContainer(
                        profileImg: AppConstants.girlsPhoto,
                        userImg: AppConstants.girlsPhoto2,
                        fullName: "Weekend Stay",
                        userName: "@travelwithlisa",
                        deliverablesText: "1 IG Reel, 2 TikTok videos",
                        paymentText: "\$250 via Stripe",
                        progressText: "2 / 3 tasks done",
                        durationText: "Oct 12 – Oct 15, 2025",
                        viewDetailsButton: () {
                          Get.toNamed(AppRoutes.hostDealOverviewScreen);
                        },
                        messageButton: () {},
                      )),
                    ),
                  );
                } else if (tab == 1) {
                  // Active Tab
                  return Expanded(
                    child: ListView(
                      children: List.generate(5, (index) => CustomDealsContainer(
                        profileImg: AppConstants.girlsPhoto,
                        userImg: AppConstants.girlsPhoto2,
                        fullName: "Active Deal $index",
                        userName: "@activeuser$index",
                        deliverablesText: "1 IG Reel",
                        paymentText: "\$150 via Stripe",
                        progressText: "1 / 1 tasks done",
                        durationText: "Oct 12 – Oct 15, 2025",
                        viewDetailsButton: () {},
                        messageButton: () {},
                      )),
                    ),
                  );
                } else if (tab == 2) {
                  // Pending Tab
                  return Expanded(
                    child: ListView(
                      children: List.generate(3, (index) => CustomDealsContainer(
                        profileImg: AppConstants.girlsPhoto,
                        userImg: AppConstants.girlsPhoto2,
                        fullName: "Pending Deal $index",
                        userName: "@pendinguser$index",
                        deliverablesText: "2 TikTok videos",
                        paymentText: "\$200 via Stripe",
                        progressText: "0 / 2 tasks done",
                        durationText: "Oct 12 – Oct 15, 2025",
                        viewDetailsButton: () {},
                        messageButton: () {},
                      )),
                    ),
                  );
                } else if (tab == 3) {
                  // Completed Tab
                  return Expanded(
                    child: ListView(
                      children: List.generate(12, (index) => CustomDealsContainer(
                        profileImg: AppConstants.girlsPhoto,
                        userImg: AppConstants.girlsPhoto2,
                        fullName: "Completed Deal $index",
                        userName: "@completeduser$index",
                        deliverablesText: "3 IG Reels",
                        paymentText: "\$300 via Stripe",
                        progressText: "3 / 3 tasks done",
                        durationText: "Oct 12 – Oct 15, 2025",
                        viewDetailsButton: () {},
                        messageButton: () {},
                      )),
                    ),
                  );
                } else {
                  // Request Tab
                  return Expanded(
                    child: ListView(
                      children: List.generate(10, (index) => CustomDealsContainer(
                        profileImg: AppConstants.girlsPhoto,
                        userImg: AppConstants.girlsPhoto2,
                        fullName: "Request Deal $index",
                        userName: "@requestuser$index",
                        deliverablesText: "1 IG Reel",
                        paymentText: "\$100 via Stripe",
                        progressText: "0 / 1 tasks done",
                        durationText: "Oct 12 – Oct 15, 2025",
                        viewDetailsButton: () {},
                        messageButton: () {},
                      )),
                    ),
                  );
                }
              },
            )


          ],
        ),
      ),
    );
  }
}
