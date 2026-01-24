import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/Influencer_part/inf_explore_deals_screen/widget/inf_deal_card.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_deals_container.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_nav_bar/vendor_navbar.dart';
import 'controller/all_deal_controller.dart';


class InfExploreDealsScreen extends StatelessWidget {
  InfExploreDealsScreen({super.key});
  //final HostHomeController hostHomeController = Get.put(HostHomeController());
  final AllDealController dealsController = Get.put(AllDealController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dealsController.getAllDeals(loadMore: false);
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Explore Deals"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // search field
              CustomTextField(
                isDens: true,
                fieldBorderColor: AppColors.primary2,
                fillColor: const Color(0xffF5F5F5),
                hintText: "Explore Deals by Name",
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
                  final bool isSearching = dealsController.searchQuery.value.isNotEmpty;

                  // ========= Loader =========
                  if (!isSearching && dealsController.rxDealStatus.value == Status.loading) {
                    return const Center(child: CustomLoader());
                  }

                  if (isSearching &&
                      dealsController.rxSearchDealStatus.value == Status.loading) {
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
                        dealsController.getAllDeals(loadMore: true);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: listToShow.length + (!isSearching && dealsController.isDealLoadMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < listToShow.length) {
                          final deal = listToShow[index];
                          return CampaignCard(
                            bannerImage: deal.title.images.isNotEmpty ?ApiUrl.baseUrl + deal.title.images.first : "",
                            profileImage: deal.userId.image.isNotEmpty ? ApiUrl.baseUrl+deal.userId.image : AppConstants.profileImage2,
                            hostName: deal.userId.name,
                            userName: deal.userId.username,
                            rewardTitle: "${deal.compensation.numberOfNights.toString()} Night Credits",
                            campaignTitle: deal.title.title,
                            location: deal.title.location,
                            onViewDetails: () {
                                Get.toNamed(AppRoutes.hostDealOverviewScreen,
                                  arguments: {
                                    'dealId': deal.id,
                                    'titleId': deal.title.id,
                                    'status': deal.status,
                                  },
                                );
                              },
                            onPrimaryAction: () {
                              print("Apply Now");
                            },
                            messageButton: (){
                              Get.toNamed(AppRoutes.chatScreen,
                                arguments: {
                                  'conversationId':"", //conversation.id ?? " ",
                                  'userName': deal.userId.name,
                                  'userImage':ApiUrl.baseUrl+deal.userId.image,
                                  'receiverId': deal.userId.id,
                                },
                              );
                            },
                          );

                        }
                        else {
                          // pagination loader
                          return const Padding(padding: EdgeInsets.all(12),
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
        bottomNavigationBar: InfNavbar(currentIndex: 1),
      ),
    );
  }
}
