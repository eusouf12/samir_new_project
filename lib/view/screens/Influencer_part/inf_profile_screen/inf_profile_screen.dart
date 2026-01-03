import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_nav_bar/vendor_navbar.dart';
import 'package:samir_flutter_app/view/screens/Influencer_part/inf_profile_screen/share_your_profile.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../authentication/controller/auth_controller.dart';
import '../../host_part/host_profile_screen/widgets/custom_profile_card.dart';

class InfProfileScreen extends StatelessWidget {
  InfProfileScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "My Profile"),
      bottomNavigationBar: InfNavbar(currentIndex: 3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile image and name
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.girlsPhoto,
                    height: 96.w,
                    width: 96.w,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Mehedi Bin Ab. Salam",
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
              //title
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
                  Get.toNamed(AppRoutes.infEditProfileScreen);
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
              CustomProfileCard(
                nameTitle: "Referrals",
                icons: AppIcons.giftIcon,
                color: AppColors.primary2,
                onTap: (){
                  Get.toNamed(AppRoutes.infReferralsScreen);
                },
              ),
              CustomProfileCard(
                nameTitle: "Payment Settings",
                icons: AppIcons.infpaymentIcon,
                color: AppColors.primary2,
                onTap: (){
                 // Get.toNamed(AppRoutes.hostPeferralsScreen);
                },
              ),
              CustomProfileCard(
                nameTitle: "Account Settings",
                icons: AppIcons.settingIcon,
                color: AppColors.primary2,
                onTap: (){
                  Get.toNamed(AppRoutes.infAccountSettings);
                },
              ),
              CustomProfileCard(
                nameTitle: "Subscription",
                color: AppColors.primary2,
               // icons: AppIcons.subscriptionIcon,
              ),
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
          ),
        ),
      ),
    );
  }
}
