import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_profile_screen/widgets/custom_account_card_list.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

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
                Get.toNamed(AppRoutes.infTermsScreen);
              },
            ),
            CustomAccountCardList(name: "Privacy Policy",  onTap: () {
              Get.toNamed(AppRoutes.infPrivacyScreen);
            },),
            CustomAccountCardList(name: "About us",  onTap: () {
              Get.toNamed(AppRoutes.infAboutScreen);
            },),
            CustomAccountCardList(name: "Delete Account",  onTap: () {
             // Get.toNamed(AppRoutes.hostAboutScreen);
            },),
          ],
        ),
      ),
    );
  }
}
