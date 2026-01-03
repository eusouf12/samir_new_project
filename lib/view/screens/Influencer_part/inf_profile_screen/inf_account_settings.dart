import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_profile_screen/widgets/custom_account_card_list.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';

class InfAccountSettings extends StatelessWidget {
  const InfAccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Account Settings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
        child: Column(
          children: [
            CustomAccountCardList(
              name: "Change Password",
              onTap: () {
                Get.toNamed(AppRoutes.infChangePasswordScreen);
              },
            ),
            CustomAccountCardList(
              name: "Terms of Services",
              onTap: () {
                Get.toNamed(AppRoutes.termsServicesScreen);
              },
            ),
            CustomAccountCardList(name: "Privacy Policy",  onTap: () {
              Get.toNamed(AppRoutes.privacyScreen);
            },),
            CustomAccountCardList(name: "About us",  onTap: () {
              Get.toNamed(AppRoutes.aboutScreen);
            },),
            CustomAccountCardList(name: "Delete Account",  onTap: () {
             // Get.toNamed(AppRoutes.hostAboutScreen);
              showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                    backgroundColor: AppColors.white,
                    insetPadding: EdgeInsets.all(8),
                    contentPadding: EdgeInsets.all(8),
                    content: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CustomShowDialog(
                        textColor: AppColors.black,
                        title: "Delete Account",
                        discription: "Do You Want To Delete Account",
                        showColumnButton: true,
                        showCloseButton: true,
                        rightOnTap: () {
                          Get.back();
                        },
                        leftOnTap: () {
                          // profileController.deleteAccount(userId: dmProfileController.userProfileModel.value.id?? "");
                        },
                      ),
                    ),
                  ),
              );
            },),
          ],
        ),
      ),
    );
  }
}
