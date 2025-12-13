import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_pin_code/custom_pin_code.dart';
import '../../../components/custom_text/custom_text.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Header
                const Center(
                  child: CustomText(
                    text: "HOSTINFLU",
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 130),

                // Title
                const Center(
                  child: CustomText(
                      text: "Verify Otp",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827)
                  ),
                ),

                const SizedBox(height: 20),

                // Description
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: "Verify Otp Des",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Custom OTP
                CustomPinCode(
                  controller: otpController,
                ),

                const SizedBox(height: 15),
                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButtonTwo(
                    onTap: () {
                      Get.toNamed(AppRoutes.updatePassScreen);
                    },
                    borderRadius: 16,
                    textColor: AppColors.white,
                    fillColor: AppColors.primary,
                    title: "Verify",
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 24),

                // Back to Login
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: const CustomText(
                      text: "Back To LogIn",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
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
