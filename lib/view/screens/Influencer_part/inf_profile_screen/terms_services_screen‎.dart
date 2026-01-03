import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/general_error.dart';
import 'controller/profile_controller.dart';

class TermsServicesScreen extends StatelessWidget {
  TermsServicesScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getTermsConditions();
    });
    return Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Terms Of Services',
          color: AppColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
                () {
              switch (profileController.rxTermsStatus.value) {
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
                      onTap: () => profileController.getTermsConditions());
                case Status.completed:
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        HtmlWidget(
                          profileController.termsModel.value.termsCondition != null
                              ? profileController.termsModel.value.termsCondition!
                              : 'Terms & Conditions Is Empty Data',
                          textStyle: TextStyle(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      );
  }
}