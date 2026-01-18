import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_deal_screen/controller/deals_controller.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_profile_screen/controller/host_profile_controller.dart';

import '../../../../service/api_url.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/influencer_list_host_controller.dart';

class HostSendCollaboarationScreen extends StatelessWidget {
   HostSendCollaboarationScreen({super.key});
   final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());
   final DealsController dealsController = Get.put(DealsController());
   final HostProfileController hostProfileController = Get.put(HostProfileController());
   final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String influencerId = args['id'];
    final String name = args['name'];
    final String image = args['image'];
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Send Collaboration",),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===== (HOST) =====
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomNetworkImage(
                            imageUrl: hostProfileController.userData.value?.image != null && hostProfileController.userData.value!.image.isNotEmpty
                                ? ApiUrl.baseUrl + hostProfileController.userData.value!.image
                                : AppConstants.profileImage,
                            height: 50,
                            width: 50,
                            boxShape: BoxShape.circle,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: hostProfileController.userData.value?.name ?? "",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const CustomText(
                                  text: "Host",
                                  fontSize: 12,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===== ARROW  =====
                    SizedBox(
                      width: 20,
                      child: Center(
                        child: CustomImage(
                          imageSrc: AppIcons.arrowBakBak,
                          sizeWidth: 24,
                        ),
                      ),
                    ),

                    // ===== INFLUENCER =====
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomNetworkImage(
                            imageUrl:ApiUrl.baseUrl+ image,
                            height: 50,
                            width: 50,
                            boxShape: BoxShape.circle,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: name,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const CustomText(
                                  text: "Influencer",
                                  fontSize: 12,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50),
                //Select List
                CustomText(text: "Select List",fontSize: 16.sp,fontWeight: FontWeight.w600,),
                SizedBox(height: 20),
                Obx(() => GestureDetector(
                  onTap: () {
                    if (dealsController.dealList.isEmpty) {
                      dealsController.getDeals();
                    }
                    _openDealDropdown(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            influencerListHostController.selectedDealTitle.value.isEmpty
                                ? "Select Your Deal"
                                : influencerListHostController.selectedDealTitle.value,
                            style: TextStyle(
                              fontSize: 16,
                              color: influencerListHostController.selectedDealTitle.value.isEmpty
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
                      ],
                    ),
                  ),
                )),

                SizedBox(height: 30),
                Obx((){
                  return influencerListHostController.isCreatingCollaboration.value?
                      CustomLoader()
                      :CustomButtonTwo(
                    onTap: (){
                      influencerListHostController.createCollaboration(influencerId: influencerId);
                    },
                    title: "Send Request",);
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _openDealDropdown(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Deal Dropdown",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (dealsController.dealList.isEmpty && dealsController.isDealLoading.value) {
                        return const Center(child: CustomLoader());
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !dealsController.isDealLoadMore.value) {
                            dealsController.getDeals(loadMore: true);
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: dealsController.dealList.length + (dealsController.isDealLoadMore.value ? 1 : 0),
                          separatorBuilder: (context, index) => Divider(height: 1, color: Colors.white),
                          itemBuilder: (context, index) {
                            if (index == dealsController.dealList.length) {
                              return const Padding(padding: EdgeInsets.all(10),
                                child: Center(child: CustomLoader()),
                              );
                            }

                            final item = dealsController.dealList[index];
                            return ListTile(
                              title: Text(item.title.title, style: const TextStyle(fontSize: 15)),
                              onTap: () {
                                influencerListHostController.selectedDealId.value = item.id;
                                influencerListHostController.selectedDealTitle.value = item.title.title;
                                debugPrint("Selected ID: ${influencerListHostController.selectedDealId.value}");
                                debugPrint("Selected Title: ${influencerListHostController.selectedDealTitle.value}");
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
