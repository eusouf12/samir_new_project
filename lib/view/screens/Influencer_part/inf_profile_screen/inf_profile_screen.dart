import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_nav_bar/vendor_navbar.dart';
import 'package:samir_flutter_app/view/screens/Influencer_part/inf_profile_screen/share_your_profile.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../authentication/controller/auth_controller.dart';
import '../../host_part/host_profile_screen/controller/host_profile_controller.dart';
import '../../host_part/host_profile_screen/widgets/custom_profile_card.dart';

class InfProfileScreen extends StatelessWidget {
  InfProfileScreen({super.key});
  final HostProfileController hostProfileController = Get.put(HostProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hostProfileController.getUserProfile();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: false, titleName: "My Profile"),
        bottomNavigationBar: InfNavbar(currentIndex: 3),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx((){
              if (hostProfileController.rxUserStatus.value == Status.loading) {
                return const Center(child: CustomLoader());
              }

              if (hostProfileController.userData.value == null) {
                return const Center(child: CustomText(text: "Profile not found", fontSize: 16,),);
              }
                final userData = hostProfileController.userData.value!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //profile info
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: userData.image.isNotEmpty ? ApiUrl.baseUrl + userData.image : AppConstants.profileImage2,
                          height: 96.w,
                          width: 96.w,
                          boxShape: BoxShape.circle,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "${userData.name}",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              bottom: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFACC15),
                                    Color(0xffEAB308),
                                    Color(0xffCA8A04),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  CustomImage(imageSrc: AppIcons.king),
                                  CustomText(
                                    left: 6,
                                    text: "Founder Member",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomText(
                      text: "Profile information",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      top: 20,
                      bottom: 16,
                    ),
                    //Edit profile
                    CustomProfileCard(
                      nameTitle: "Edit Profile",
                      icons: AppIcons.editIcon,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostEditProfileScreen,arguments: "inf");
                      },
                    ),
                    //Share your profile
                    CustomProfileCard(
                      nameTitle: "Share your profile",
                      icons: AppIcons.mdi_share,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.to(ShareProfileScreen());
                      },
                    ),
                    //referrals
                    CustomProfileCard(
                      nameTitle: "Referrals",
                      icons: AppIcons.giftIcon,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostReferralsScreen,arguments: "inf");
                      },
                    ),
                    //Change Password
                    CustomProfileCard(
                      nameTitle: "Change Password",
                      icons: AppIcons.changePass,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostChangePasswordScreen,arguments: "inf");
                      },
                    ),
                    //Terms of services
                    CustomProfileCard(
                      nameTitle: "Terms of services",
                      icons: AppIcons.terms,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostTermsScreen,arguments: "inf");
                      },
                    ),
                    //Privacy Policy
                    CustomProfileCard(
                      nameTitle: "Privacy Policy",
                      icons: AppIcons.privacyPolicy,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostPrivacyScreen,arguments: "inf");
                      },
                    ),
                    //About us
                    CustomProfileCard(
                      nameTitle: "About us",
                      icons: AppIcons.aboutUs,
                      color: AppColors.primary2,
                      onTap: (){
                        Get.toNamed(AppRoutes.hostAboutScreen,arguments: "inf");
                      },
                    ),
                    //delete account
                    CustomProfileCard(
                        nameTitle: "Delete Account",
                        icons: AppIcons.logoutIcon,
                        color: AppColors.primary2,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (ctx) =>
                                AlertDialog(
                                  backgroundColor: AppColors.white,
                                  insetPadding: EdgeInsets.all(8),
                                  contentPadding: EdgeInsets.all(8),
                                  content: SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: CustomShowDialog(
                                      textColor: AppColors.black,
                                      title: "Delete Your Account",
                                      discription: "Are You Sure Delete Your Account",
                                      showColumnButton: true,
                                      showCloseButton: true,
                                      rightOnTap: () {
                                        Get.back();
                                      },
                                      leftOnTap: () async {
                                        await SharePrefsHelper.clearAll();
                                        Get.offAllNamed(AppRoutes.loginScreen);
                                      },
                                    ),
                                  ),
                                ),
                          );
                        }
                    ),
                   //payment Setting
                    CustomProfileCard(
                      nameTitle: "Payment Settings",
                      icons: AppIcons.infpaymentIcon,
                      color: AppColors.primary2,
                      onTap: (){
                        // Get.toNamed(AppRoutes.hostPeferralsScreen);
                      },
                    ),
                    //Log Out
                    CustomProfileCard(
                        nameTitle: "Log Out",
                        color: AppColors.primary2,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (ctx) =>
                                AlertDialog(
                                  backgroundColor: AppColors.white,
                                  insetPadding: EdgeInsets.all(8),
                                  contentPadding: EdgeInsets.all(8),
                                  content: SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: CustomShowDialog(
                                      textColor: AppColors.black,
                                      title: "Logout Your Account",
                                      discription: "Are You Sure Logout",
                                      showColumnButton: true,
                                      showCloseButton: true,
                                      rightOnTap: () {
                                        Get.back();
                                      },
                                      leftOnTap: () async {
                                        await SharePrefsHelper.clearAll();
                                        Get.offAllNamed(AppRoutes.loginScreen);
                                      },
                                    ),
                                  ),
                                ),
                          );
                        })
                  ],
                );
              }),
          )
          ),
        ),
    );
  }
}
