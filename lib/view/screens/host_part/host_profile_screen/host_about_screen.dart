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

class HostAboutScreen extends StatelessWidget {
  HostAboutScreen({super.key});

  final HostProfileController profileController = Get.put(HostProfileController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getAboutUs();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'About Us',
          color: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
                () {
              switch (profileController.rxAboutStatus.value) {
                case Status.loading:
                  return Center(
                    child: CustomLoader(),
                  );
                case Status.internetError:
                  return Center(
                    child: CustomLoader(),
                  );
                case Status.error:
                  return GeneralErrorScreen(
                      onTap: () => profileController.getAboutUs());
                case Status.completed:
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        HtmlWidget(
                          profileController.aboutUsModel.value?.description.isNotEmpty == true
                              ? profileController.aboutUsModel.value!.description
                              : 'About Us content not available',
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )

                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}