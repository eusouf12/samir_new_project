import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/general_error.dart';
import 'controller/host_profile_controller.dart';

class HostTermsScreen extends StatelessWidget {
  HostTermsScreen({super.key});
  final HostProfileController profileController = Get.put(HostProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getTermsConditions();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: const CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Terms & EULA',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // EULA & Zero Tolerance Notice Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.gavel_rounded, color: AppColors.primary, size: 22),
                          SizedBox(width: 8),
                          Text(
                            "End User License Agreement (EULA)",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Zero-Tolerance Policy for Objectionable Content & Abusive Behavior",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "HostInflu maintains a strict zero-tolerance policy against any form of objectionable, defamatory, offensive, harassing, hateful, sexually explicit, or abusive content and behavior. Any user who posts prohibited content or engages in abusive actions will have their content removed immediately and their account permanently terminated within 24 hours of reporting.",
                        style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "User Moderation & Safety Rights:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "• Flag/Report: Users can flag any objectionable content or user anywhere in the app.\n• Block: Users can instantly block any abusive user to remove all their content from view.\n• 24-Hour Action: All reports are reviewed and acted upon within 24 hours.",
                        style: TextStyle(fontSize: 11.5, color: Colors.black87, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Backend Terms & Conditions Content
                Obx(() {
                  switch (profileController.rxStatus.value) {
                    case Status.loading:
                      return Center(child: CustomLoader());
                    case Status.internetError:
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No Internet Connection"),
                        ),
                      );
                    case Status.error:
                      return Center(
                        child: GeneralErrorScreen(
                          onTap: () => profileController.getTermsConditions(),
                        ),
                      );
                    case Status.completed:
                      final description = profileController.termsModel.value?.description ?? "";
                      if (description.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            "By accessing or using HostInflu, you agree to comply with and be bound by these Terms of Service and End User License Agreement. All interactions between hosts and creators must remain professional, respectful, and free of abusive conduct.",
                            style: TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
                          ),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: HtmlWidget(
                          description,
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                  }
                }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}