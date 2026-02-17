import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/service/api_url.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/collabration_controller.dart';
import '../widget/custom_collaboration_card.dart';

class HostCollaborationScreen extends StatelessWidget {
  HostCollaborationScreen({super.key});

  final CollaborationController controller = Get.put(CollaborationController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      controller.currentIndex.value = 0;
      String id = await SharePrefsHelper.getString(AppConstants.userId);
      controller.getSingleUserCollaboration(id: id);
      controller.getSingleUser(userId: id);
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
              Obx(() {
              final userData = controller.singleUserProfile;

              // Null safety check
              final total = userData.value?.collaborationStats?.total ?? 0;
              final pending = userData.value?.collaborationStats?.pending?.count ?? 0;
              final approved = userData.value?.collaborationStats?.ongoing?.count ?? 0;
              final declined = userData.value?.collaborationStats?.rejected?.count ?? 0;
              final accepted = userData.value?.collaborationStats?.accepted?.count ?? 0;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "$total",
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
                        text: "$pending",
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
                        text: "$accepted",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff22C55E),
                      ),
                      CustomText(
                        text: "Accepted",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "$approved",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff22C55E),
                      ),
                      CustomText(
                        text: "Ongoing",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: "$declined",
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
              );
            }),
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
                  if (controller.singleUserCollaborationStatus.value == Status.loading ) {
                    return const Center(child: CustomLoader());
                  }
                  if (controller.singleUserCollaborationStatus.value == Status.error) {
                    return Center(
                      child: Text("Failed to load collaborations", style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    );
                  }
                  if (controller.singleUserCollaborationList.isEmpty) {
                    return Center(child: Text("No collaborations found", style: TextStyle(fontSize: 16.sp),),);
                  }
                  final userData = controller.singleUserProfile;
                  return NotificationListener<ScrollNotification>(
                    // onNotification: (scrollInfo) {
                    //   if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !controller.isCollaborationLoadMore.value) {
                    //     controller.getMyCollaborations(loadMore: true);
                    //   }
                    //   return false;
                    // },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: controller.singleUserCollaborationList.length,
                        itemBuilder: (context, index) {
                          final collaboration = controller.singleUserCollaborationList[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomCollaborationCard(
                              profileImage: (collaboration.selectInfluencerOrHost?.image?.isNotEmpty ?? false) ? ApiUrl.baseUrl + collaboration.selectInfluencerOrHost!.image! : "",
                              userName: collaboration.selectInfluencerOrHost?.name,
                              userHandle:  collaboration.selectInfluencerOrHost?.userName,
                              status: collaboration.status,
                              location: collaboration.selectDeal?.title?.title ?? "",
                               socialMediaLinks: collaboration.selectInfluencerOrHost?.socialMediaLinks ?? [],

                              // ===== Dynamic Callbacks =====
                              onViewDetailsTap: () {

                                debugPrint("=========== COLLABORATION DETAILS ===========");

                                debugPrint("image: ${ (collaboration.selectInfluencerOrHost?.image?.isNotEmpty ?? false)
                                    ? ApiUrl.baseUrl + collaboration.selectInfluencerOrHost!.image!
                                    : "" }");

                                debugPrint("name: ${collaboration.selectInfluencerOrHost?.name}");
                                debugPrint("userName: ${collaboration.selectInfluencerOrHost?.userName}");
                                debugPrint("listingName: ${collaboration.selectDeal?.title?.title}");

                                debugPrint("listingImage: ${ (collaboration.selectDeal?.title?.images?.isNotEmpty ?? false)
                                    ? ApiUrl.baseUrl + collaboration.selectDeal!.title!.images!.first
                                    : "" }");

                                debugPrint("payment: ${collaboration.compensation?.paymentAmount}");
                                debugPrint("nightStay: ${collaboration.compensation?.numberOfNights}");
                                debugPrint("guestCount: ${collaboration.guestCount}");

                                debugPrint("inTimeAndDate: ${collaboration.selectDeal?.inTimeAndDate}");
                                debugPrint("outTimeAndDate: ${collaboration.selectDeal?.outTimeAndDate}");

                                debugPrint("amenities: ${collaboration.selectDeal?.title?.amenities}");
                                debugPrint("deliverables: ${collaboration.deliverables}");
                                debugPrint("socialMediaLinks: ${collaboration.selectInfluencerOrHost?.socialMediaLinks}");

                                debugPrint("status: ${collaboration.status}");
                                debugPrint("userId: ${collaboration.selectInfluencerOrHost?.id}");
                                debugPrint("collabrationId: ${collaboration.id}");

                                debugPrint("=============================================");
                                Get.toNamed(
                                  AppRoutes.hostCollaborationViewDetailsScreen,
                                  arguments: {
                                    "image": (collaboration.selectInfluencerOrHost?.image?.isNotEmpty ?? false) ? ApiUrl.baseUrl + collaboration.selectInfluencerOrHost!.image! : "",
                                    "name": collaboration.selectInfluencerOrHost?.name ?? "",
                                    "userName": collaboration.selectInfluencerOrHost?.userName ?? "",
                                    "listingName": collaboration.selectDeal?.title?.title ?? "",
                                    "listingImage": (collaboration.selectDeal?.title?.images?.isNotEmpty ?? false) ? ApiUrl.baseUrl + collaboration.selectDeal!.title!.images!.first : "",
                                    "payment": collaboration.compensation?.paymentAmount ?? "0",
                                    "nightStay": collaboration.compensation?.numberOfNights ?? 0,
                                    "inTimeAndDate": collaboration.inTimeAndDate ?? "",
                                    "outTimeAndDate": collaboration.outTimeAndDate ?? "",
                                    "guestCount": collaboration.guestCount ?? 0,
                                    "amenities": collaboration.selectDeal?.title?.amenities,
                                    "deliverables": collaboration.deliverables ?? [],
                                    "socialMediaLinks": collaboration.selectInfluencerOrHost?.socialMediaLinks ?? [],
                                    "status" : collaboration.status,
                                    "userId" : collaboration.selectInfluencerOrHost?.id,
                                    "collabrationId" : collaboration.id,
                                  },
                                );
                              },
                              onPaymentTap: (){
                                  // Get.toNamed(
                                  //     AppRoutes.hostCollaborationViewDetailsScreen,
                                  // );
                                },
                              onApproveTap: () {

                                 controller.acceptRejected(action: 'accept', userId: collaboration.selectInfluencerOrHost?.id ?? "", collabrationId: collaboration.id ?? "");
                              },
                              onDeclineTap: () {
                                controller.acceptRejected(action: 'reject', userId: collaboration.selectInfluencerOrHost?.id ?? "", collabrationId: collaboration.id ?? "");
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

