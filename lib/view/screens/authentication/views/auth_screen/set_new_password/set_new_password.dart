import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../controller/auth_controller.dart';


class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    // final size = MediaQuery.sizeOf(context);
    return  Scaffold(
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                //image
                CustomImage(
                  imageSrc: AppImages.splashScreenImage,
                  height: 50.h,
                  width: 50.w,
                ),
                const SizedBox(height: 30),

                // Title
                Center(
                  child: CustomText(
                    text: "SET A NEW PASSWORD",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    bottom: 10,
                  ),
                ),

                // Description
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: "Password  must have 6-8 characters.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New Password
                    const CustomText(
                      text: "New Password",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textEditingController: authController.updatePasswordController.value,
                      hintText: "Enter password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF9CA3AF), size: 22),
                      isPassword: true,
                      fillColor: AppColors.white,
                      fieldBorderColor: const Color(0xFFE5E7EB),
                      fieldBorderRadius: 12,
                    ),

                    const SizedBox(height: 20),
                    // Confirm New Password
                    const CustomText(
                      text:"Confirm New Password",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textEditingController: authController.updateConfirmPasswordController.value,
                      hintText: "Enter Confirm password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF9CA3AF), size: 22),
                      isPassword: true,
                      fillColor: AppColors.white,
                      fieldBorderColor: const Color(0xFFE5E7EB),
                      fieldBorderRadius: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Update Password Button
                Obx(() {
                  return authController.updatePasswordLoading.value
                      ? CustomLoader()
                      : SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CustomButton(
                      onTap: () {
                        authController.updatePassword();
                      },
                      borderRadius: 12,
                      textColor: AppColors.white,
                      title: "Update Password",
                      fillColor:  AppColors.lightGreen,
                      fontSize: 16,
                    ),
                  );
                }),
                const SizedBox(height: 24),
                // Back to Login
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: const CustomText(
                        text: "Back to Login",
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFDD835)
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      );
  }
}
