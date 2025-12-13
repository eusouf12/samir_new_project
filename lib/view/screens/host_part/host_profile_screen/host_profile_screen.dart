import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_profile_screen/widgets/custom_profile_card.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_nav_bar/navbar.dart';
import '../../../components/custom_text/custom_text.dart';

class HostProfileScreen extends StatelessWidget {
  const HostProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "My Profile"),
      bottomNavigationBar: HostNavbar(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            CustomText(
              text: "Profile information",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              top: 20,
              bottom: 16,
            ),
            CustomProfileCard(
              nameTitle: "Edit Profile",
              icons: AppIcons.editIcon,
              onTap: (){
                Get.toNamed(AppRoutes.hostEditProfileScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Referrals",
              icons: AppIcons.giftIcon,
              onTap: (){
                Get.toNamed(AppRoutes.hostPeferralsScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Account Settings",
              icons: AppIcons.settingIcon,
              onTap: (){
                Get.toNamed(AppRoutes.hostAccountSettings);
              },
            ),
            CustomProfileCard(
              nameTitle: "Subscription",
              icons: AppIcons.subscriptionIcon,
            ),
            CustomProfileCard(
              onTap: (){
                Get.toNamed(AppRoutes.chooseRole);
              },
              nameTitle: "Logout",
              icons: AppIcons.logoutIcon,
            ),
          ],
        ),
      ),
    );
  }
}
