import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_deal_screen/controller/deals_controller.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_deals_container.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_tab_selected/custom_tab_selected.dart';
import '../../host_home_screen/controller/host_home_controller.dart';


class HostDealsScreen extends StatelessWidget {
  HostDealsScreen({super.key});
  final HostHomeController hostHomeController = Get.find<HostHomeController>();
  final DealsController dealsController = Get.find<DealsController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dealsController.getDeals(loadMore: false);
    });
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
            Obx( () => CustomTabSelector(
                tabs: hostHomeController.tabNames,
                selectedIndex: hostHomeController.selectedTab.value,
                selectedColor: AppColors.primary,
                unselectedColor: Colors.black,
                onTabSelected: hostHomeController.changeTab,
              ),
            ),
            SizedBox(height: 10.h),
            // deals list
            Obx(() {
                int tab = hostHomeController.selectedTab.value;

                // All Tab
                if (tab == 0) {
                  return
                    Expanded(
                      child: Obx(() {
                        if (dealsController.isDealLoading.value && dealsController.dealList.isEmpty) {
                          return const Center(child: CustomLoader());
                        }
                        else if (dealsController.dealList.isEmpty) {
                          return const Center(child: Text("No deals available"));
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !dealsController.isDealLoadMore.value) {
                              dealsController.getDeals(loadMore: true);
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount: dealsController.dealList.length + (dealsController.isDealLoadMore.value ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == dealsController.dealList.length) {
                                return const Padding(padding: EdgeInsets.all(12),
                                  child: Center(child: CustomLoader()),
                                );
                              }

                              final deal = dealsController.dealList[index];

                              final order = ['IG', 'TT', 'FB', 'YT'];

                              final deliverablesText = deal.deliverables.map((d) => {'platform': getPlatformShort(d.platform ?? ''), 'text': "${d.quantity} ${getPlatformShort(d.platform ?? '')} ${d.contentType}"})
                                  .where((e) => e['platform']!.isNotEmpty).toList()..sort((a, b) => order.indexOf(a['platform']!).compareTo(order.indexOf(b['platform']!)));

                              final text = deliverablesText.map((e) => e['text']).join(', ');


                              // payment text
                              String paymentText = "";
                              if (deal.compensation.directPayment) {
                                paymentText = "\$${deal.compensation.paymentAmount ?? '0'} via Direct Payment";
                              }
                              else if (deal.compensation.nightCredits) {paymentText = "${deal.compensation.numberOfNights} night credits";}

                              // duration text
                              final inDate = "${deal.inTimeAndDate.day}-${deal.inTimeAndDate.month}-${deal.inTimeAndDate.year}";
                              final outDate = "${deal.outTimeAndDate.day}-${deal.outTimeAndDate.month}-${deal.outTimeAndDate.year}";
                              final durationText = "$inDate – $outDate";

                              // progress text (optional)
                              final progressText = "Tasks info here";

                              return CustomDealsContainer(
                                profileImg: deal.userId.id.isNotEmpty ?ApiUrl.baseUrl + deal.title.images.first : AppConstants.profileImage2,
                                userImg: deal.title.images.isNotEmpty ? ApiUrl.baseUrl+deal.userId.image : AppConstants.profileImage2,
                                fullName: deal.title.title,
                                userName: "${deal.userId.name}",
                                status: deal.status,
                                deliverablesText: text,
                                paymentText: paymentText,
                                progressText: progressText,
                                durationText: durationText,
                                viewDetailsButton: () {
                                  Get.toNamed(AppRoutes.hostDealOverviewScreen, arguments: deal);
                                },
                                messageButton: () {
                                  // message action
                                },
                              );
                            },
                          ),
                        );
                      }),
                    );
                }
                // Active Tab
                else if (tab == 1) {
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
                }
                // Pending Tab
                else if (tab == 2) {
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
                }
                // Completed Tab
                else if (tab == 3) {
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
                }
                // Request Tab
                else {
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
