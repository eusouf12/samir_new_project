import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_images/app_images.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_text/custom_text.dart';
import '../custom_role/custom_role.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.                                                        back();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: CustomText(
                    text: "Hostinflu",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: CustomText(
                    text: "Choose your role",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black
                  ),
                ),
                const Center(
                  child: CustomText(
                    top: 10,
                      text: "Select how you want to use Hostinflu",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr
                  ),
                ),
                const SizedBox(height: 25),

                Expanded(
                  child: ListView(
                    children: [
                      CustomRole(
                        icon: AppImages.home,
                        title: "Host",
                        description: "List your property and collaborate with influencers",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostHomeScreen);
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomRole(
                        icon: AppImages.camara,
                        title: "Influencer",
                        // description: AppStrings.guestDes,
                        description: "Promote listings and earn through collaborations",
                        onTap: () {
                          Get.toNamed(AppRoutes.infHomeScreen);
                        },
                      ),
                      SizedBox(height: 30,),
                      CustomButtonTwo(
                        onTap: () {
                          Get.toNamed(AppRoutes.loginScreen);
                        },
                        title: "Continue",
                        fillColor: AppColors.primary,
                        textColor: AppColors.white,
                        borderRadius: 16,
                        fontSize: 16,
                      ),
                      SizedBox(height: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: 'Need help?', fontSize: 14, fontWeight: FontWeight.w400,),
                          SizedBox(width: 3,),
                          CustomText(text: 'Contract Support', fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary,),
                        ]
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}












