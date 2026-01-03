import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import '../../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../controller/auth_controller.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final SignUpAuthModel? userModel = Get.arguments as SignUpAuthModel?;

  @override
  Widget build(BuildContext context) {
    return  CustomGradient(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24,right: 24,top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                      child: CustomText(
                        text: "HOSTINFLU",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 50),
                    // Title
                    Center(
                      child: CustomText(
                        text: "Forget Password",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        bottom: 10,
                      ),
                    ),
                    // Description
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: CustomText(
                          text: "Enter your registered email we'll send you a link to reset your password.",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
      
                    // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          textEditingController:  authController.forgetPasswordController.value,
                          hintText: AppStrings.enterYourEmail,
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.email, color: Colors.grey, size: 20),
                          fillColor: AppColors.white,
                          fieldBorderColor: const Color(0xFFE5E7EB),
                          fieldBorderRadius: 12,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                     SizedBox(height: 25),
                    // Send Button
                    Obx(() {
                      return authController.forgetPasswordLoading.value
                          ? CustomLoader()
                          :
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: CustomButton(
                          onTap: () {
                            if (authController.forgetPasswordController.value.text.isEmpty) {
                              showCustomSnackBar('emailFieldCantBeEmpty'.tr, isError: true);
                              return;
                            }
                            authController.forgetPassword(
                              screenName: userModel?.screenName ?? "",
                            );
                          },
                          borderRadius: 12,
                          textColor: AppColors.white,
                          fillColor: AppColors.lightGreen,
                          title: "Request OTP",
                          fontSize: 16,
                        ),
                      );
                    }),
      
                    const SizedBox(height: 30),
      
                    // Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const CustomText(
                            text: "Back to Login",
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightGreen
                        ),
                      ),
                    ),
      
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


