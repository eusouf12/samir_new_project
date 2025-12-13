import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/screens/Influencer_part/inf_home_screen/widgets/inf_custom_total_deals_card.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import 'controller/inf_home_controller.dart';
class InfTotalDealsScreen extends StatelessWidget {
   InfTotalDealsScreen({super.key});
  final infHomeController= Get.find<InfHomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomTextField(
              fieldBorderColor: AppColors.primary2,
              fillColor: AppColors.white,
              isDens: true,
              hintText: "Search deals by name",
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: AppColors.textClr,
              ),
              hintStyle: TextStyle(color: AppColors.textClr),
            ),
            SizedBox(height: 16),
            Obx(() => CustomTabBar(
              textColor: AppColors.white,
              tabs: infHomeController.collaborationTabList,
              selectedIndex: infHomeController.currentIndex.value,
              onTabSelected: (value) {
                infHomeController.currentIndex.value = value;

                if (value == 0) {

                } else if (value == 1) {

                } else if (value == 2) {
                }
              },
              selectedColor: AppColors.primary2,
            )),
            Expanded(
              child: ListView(
                children: List.generate(10, (index) => InfCustomTotalDealsCard(
                  profileImg: AppConstants.girlsPhoto,
                  userImg: AppConstants.girlsPhoto2,
                  fullName: "Weekend Stay",
                  userName: "@travelwithlisa",
                  deliverablesText: "1 IG Reel, 2 TikTok videos",
                  paymentText: "\$250 via Stripe",
                  progressText: "2 / 3 tasks done",
                  durationText: "Oct 12 – Oct 15, 2025",
                  viewDetailsButton: () {
                    //Get.toNamed(AppRoutes.hostDealOverviewScreen);
                  },
                  messageButton: () {},

                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
