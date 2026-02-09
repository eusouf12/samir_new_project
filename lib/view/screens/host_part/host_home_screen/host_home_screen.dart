import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_activity_card.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_container_card.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_nav_bar/navbar.dart';
import '../collaboration_screen/controller/collabration_controller.dart';
import '../host_active_influe/controller/influencer_list_host_controller.dart';
import '../host_listing_screen/controller/listing_controller.dart';

class HostHomeScreen extends StatelessWidget {
  HostHomeScreen({super.key});
 // final HostProfileController hostProfileController = Get.put(HostProfileController());
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final ListingController listingController = Get.put(ListingController());
  final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      String id = await SharePrefsHelper.getString(AppConstants.userId);
     // hostProfileController.getUserProfile();
      collaborationController.getSingleUser(userId: id);
      listingController.getListings(loadMore: false);
      influencerListHostController.getInfluencers();
    });
    return CustomGradient(
      child: Scaffold(
        body:
        Obx((){
          if (collaborationController.rxGetSingleUserStatus.value == Status.loading) {
            return const Center(child: CustomLoader());
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
                        Get.toNamed(AppRoutes.hostNotificationScreen);
                      },
                      child: CustomImage(imageSrc: AppIcons.notifacationLoadIcon),
                    ),
                  ],
                ),
                // scroll 5 card
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainerCard(
                        title: "Deals",
                        color: AppColors.white,
                        textColor: AppColors.black,
                        number: "${userData.value?.dealsTotal}",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostDealsScreen);
                        },
                      ),
                      SizedBox(width: 16),
                      //Listings
                      CustomContainerCard(
                        title: "My\nListings",
                        color: AppColors.white,
                        textColor: AppColors.black,
                        number: "${userData.value?.totalListings}",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostListingScreen);
                        },
                      ),
                      SizedBox(width: 16),
                      //Influencer
                      CustomContainerCard(
                        onTap: () {
                          Get.toNamed(AppRoutes.hostActiveInflue);
                        },
                        title: "Active\nInfluencer",
                        color: AppColors.white,
                        textColor: AppColors.black,
                        number: influencerListHostController.influencerList.length.toString(),
                      ),
                      SizedBox(width: 16),
                      //Redeem Requests
                      // CustomContainerCard(
                      //   title: "Redeem\n Requests",
                      //   color: AppColors.white,
                      //   textColor: AppColors.black,
                      //   number: "0",
                      //   onTap: () {
                      //     Get.toNamed(AppRoutes.hostListingScreen);
                      //   },
                      // ),
                      // SizedBox(width: 16),
                      CustomContainerCard(
                        onTap: () {
                          Get.toNamed(AppRoutes.hostCollaborationScreen);
                        },
                        title: "Total\n Collaboration",
                        color: AppColors.white,
                        textColor: AppColors.black,
                        number: "${userData.value?.collaborationStats?.total}",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // create and add
                CustomButtonTwo(
                  onTap: () {
                    Get.toNamed(AppRoutes.hostCreateDealScreen, arguments: {"page": "deal", "id": ""});
                  },
                  title: "Create Deal",
                  borderRadius: 10,
                ),
                SizedBox(height: 16),
                CustomButtonTwo(
                  onTap: () {
                    Get.toNamed(AppRoutes.hostAddNewListingScreen);
                  },
                  title: "Add Listing",
                  borderRadius: 10,
                  isBorder: true,
                  borderColor: AppColors.primary,
                  borderWidth: 1,
                  fillColor: AppColors.white,
                  textColor: AppColors.black,
                ),
                // Recent Activity
                CustomText(
                  top: 20,
                  text: "Recent Activity",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  bottom: 16,
                ),
                CustomActivityCard(
                  onTap: () {
                    Get.toNamed(AppRoutes.hostCollaborationScreen);
                  },
                  icon: AppIcons.collaboraIcon,
                  title: "Collaboration",
                  time: "2 hours ago",
                  number: "5",
                ),
                CustomActivityCard(
                  onTap: (){
                    Get.toNamed(AppRoutes.hostRedeemRequestScreen);
                  },
                  title: "Redeem Night Requests",
                  icon: AppIcons.redeemIcon,
                  time: "1 day ago",
                  number: "1",
                ),
                CustomActivityCard(
                  title: "Payment Processed",
                  icon: AppIcons.paymentIcon,
                  time: "2 day ago",
                  number: "3",
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: HostNavbar(currentIndex: 0),
      ),
    );
  }
}
