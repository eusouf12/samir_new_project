import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import 'controller/host_profile_controller.dart';
class HostChangePasswordScreen extends StatelessWidget {
   HostChangePasswordScreen({super.key});
  final HostProfileController profileController = Get.put(HostProfileController());
   final page = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40.0),
        child: Column(
          children: [
            CustomFormCard(
              title: "Old Password",
              isPassword: true,
              controller: profileController.oldPasswordController.value,
            ),
            CustomFormCard(
              title: "New Password",
              isPassword: true,
              controller: profileController.newPasswordController.value,
            ),
            CustomFormCard(
              title: "Confirm New Password",
              isPassword: true,
              controller: profileController.confirmPasswordController.value,
            ),
            Spacer(),
            Obx((){
              if (profileController.changePassLoading.value) {
                return  CustomLoader();
              }
              return CustomButtonTwo(
                onTap: () {
                  profileController.changePassword();
                },
                title: "UPDATE PASSWORD",
                textColor: AppColors.white,
                fillColor: page == "host" ? AppColors.primary : AppColors.primary2,
              );
            })

          ],
        ),
      ),
    );
  }
}
