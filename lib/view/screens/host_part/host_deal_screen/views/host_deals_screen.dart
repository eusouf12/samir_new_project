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


class HostDealsScreen extends StatelessWidget {
  HostDealsScreen({super.key});
  //final HostHomeController hostHomeController = Get.put(HostHomeController());
  final DealsController dealsController = Get.put(DealsController());

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
              isDens: true,
              fillColor: const Color(0xffF5F5F5),
              hintText: "Search deals by name ",
              hintStyle: TextStyle(color: AppColors.textClr),
              prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textClr),
              onChanged: (value) {
                dealsController.searchQuery.value = value;

                if (value.trim().isEmpty) {
                  dealsController.searchDealList.clear();
                  dealsController.setSearchDealStatus(Status.completed);
                } else {
                  dealsController.searchDeals(query: value);
                }
              },
            ),
            SizedBox(height: 16),
            SizedBox(height: 10.h),
            // deals list
            Expanded(
              child: Obx(() {
                final bool isSearching =
                    dealsController.searchQuery.value.isNotEmpty;

                // ========= Loader =========
                if (!isSearching && dealsController.rxDealStatus.value == Status.loading) {
                  return const Center(child: CustomLoader());
                }

                if (isSearching && dealsController.rxSearchDealStatus.value == Status.loading) {
                  return const Center(child: CustomLoader());
                }

                // ========= Decide list =========
                final listToShow = isSearching ? dealsController.searchDealList : dealsController.dealList;

                if (listToShow.isEmpty) {
                  return const Center(child: Text("No deals available"));
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!isSearching && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !dealsController.isDealLoadMore.value) {
                      dealsController.getDeals(loadMore: true);
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: listToShow.length +
                        (!isSearching && dealsController.isDealLoadMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < listToShow.length) {
                        final deal = listToShow[index];
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
                        final durationText = "$inDate to $outDate";

                        // progress text (optional)
                        final progressText = "Tasks info here";

                        return CustomDealsContainer(
                          profileImg: deal.title.images.isNotEmpty ?ApiUrl.baseUrl + deal.title.images.first : AppConstants.profileImage2,
                          userImg:  deal.userId.image.isNotEmpty ? ApiUrl.baseUrl+deal.userId.image : AppConstants.profileImage2,
                          fullName: deal.title.title,
                          userName: "${deal.userId.name}",
                          status: deal.status,
                          deliverablesText: text,
                          paymentText: paymentText,
                          progressText: progressText,
                          durationText: durationText,
                          viewDetailsButton: () {
                            Get.toNamed(AppRoutes.hostDealOverviewScreen,
                              arguments: {
                                'dealId': deal.id,
                                'titleId': deal.title.id,
                                'status': deal.status,
                              },
                            );
                          },
                        );
                      }
                      else {
                        // pagination loader
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(child: CustomLoader()),
                        );
                      }
                    },
                  ),
                );
              }),
            ),


          ],
        ),
      ),
    );
  }
}
