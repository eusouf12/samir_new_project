import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_pin_code/custom_pin_code.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../controller/auth_controller.dart';
// ==================== Two-Factor Authentication OTP Screen ====================
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final SignUpAuthModel userModel = Get.arguments as SignUpAuthModel;
  final RxInt resendTimer = 24.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.startOtpTimer();
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              CustomImage(
                imageSrc: AppImages.splashScreenImage,
                height: 50.h,
                width: 50.h,
              ),
              SizedBox(height: 80.h),

              CustomText(
                text: 'Two-Factor Authentication',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: 'Check your email/SMS for the code.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(height: 40.h),

              // PIN Code Input (Connected to Controller)
              CustomPinCode(controller: authController.otpController.value,),
              SizedBox(height: 30.h),
              userModel.screenName == "Sign up" ?
              Obx(() {
                debugPrint("userModel.screenName == ${userModel.screenName}");
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: authController.canResend.value
                            ? "You can resend now"
                            : "Resend code in 00:${authController.otpTimer.value
                            .toString().padLeft(2, '0')}",
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ],
                  ),
                );
              }) : const SizedBox(),
              const SizedBox(height: 30),

              SizedBox(height: 40.h),

              Obx(() {
                return authController.otpLoading.value
                    ? CustomLoader()
                    : CustomButton(
                  onTap: () {
                    if (authController.otpController.value.text.isEmpty) {
                      showCustomSnackBar(
                        "Field Can't Be Empty", isError: true,);
                      return;
                    }
                    userModel.screenName == "Sign up"
                        ? authController.verifyOtp(
                      screenName: userModel.screenName,)
                        : authController.verifyOtpForgetPass();
                  },
                  borderRadius: 12,
                  textColor: AppColors.white,
                  fillColor: AppColors.primary,
                  title: "Verify",
                  fontSize: 16,
                );
              }),

              SizedBox(height: 20.h),
              // Resend Option
              Obx(() {
                if (!authController.canResend.value) {
                  return const SizedBox();
                }

                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Didn't receive the code? ",
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint(
                              "Resend OTP ======== ${userModel.screenName}");
                          authController.resendOtp(email: userModel.email);
                        },
                        child: CustomText(
                          text: "Resend",
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFDD835),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: 20.h),

              // Back Button
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.loginScreen),
                child: CustomText(
                  text: 'Back to Login',
                  fontSize: 14.sp,
                  color: const Color(0xFF2DD4BF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

