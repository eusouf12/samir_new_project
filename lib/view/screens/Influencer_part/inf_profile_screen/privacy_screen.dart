import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/general_error.dart';
import 'controller/profile_controller.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileController.privacyModel.value.privacyPolicy == null) {
        profileController.getPrivacyPolicy();
      }
    });
    return  Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: 'Privacy Policy',
        color: AppColors.white,
      ),
      body: Obx(() {
        switch (profileController.rxPrivacyPolicyStatus.value) {
          case Status.loading:
            return  Center(child: CustomLoader());

          case Status.internetError:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.grey),
                  SizedBox(height: 10.h),
                  Text("No internet connection", style: TextStyle(fontSize: 18.sp, color: AppColors.white)),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    // onPressed: () => profileController.getPrivacyPolicy(),
                    onPressed: () {},
                    child: const Text("Retry", style: TextStyle(color: AppColors.white)),
                  ),
                ],
              ),
            );

          case Status.error:
            return GeneralErrorScreen(
              // onTap: () => profileController.getPrivacyPolicy(),
              onTap: () => Get.back(),
            );

          case Status.completed:
            final htmlContent = profileController.privacyModel.value.privacyPolicy?.trim() ?? '';
            if (htmlContent.isEmpty) {
              return Center(
                child: Text(
                  "Privacy Policy is empty",
                  style: TextStyle(fontSize: 18.sp, color: AppColors.white),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: HtmlWidget(
                htmlContent,
                textStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      }),
    );

  }
}
