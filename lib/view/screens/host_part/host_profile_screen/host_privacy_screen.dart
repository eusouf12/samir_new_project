import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/general_error.dart';
import 'controller/host_profile_controller.dart';

class HostPrivacyScreen extends StatelessWidget {
  HostPrivacyScreen({super.key});
  final HostProfileController profileController = Get.put(HostProfileController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getPrivacyPolicy();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Privacy Policy',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            switch (profileController.rxPrivacyStatus.value) {
              case Status.loading:
                return  Center(child: CustomLoader());
              case Status.internetError:
                return const Center(child: Text("No Internet Connection"));
              case Status.error:
                return Center(
                  child: GeneralErrorScreen(
                    onTap: () => profileController.getPrivacyPolicy(),
                  ),
                );
              case Status.completed:
                return SingleChildScrollView(
                  child: HtmlWidget(
                    profileController.privacyModel.value?.description.isNotEmpty == true
                        ? profileController.privacyModel.value!.description
                        : 'Privacy Policy not available',
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}