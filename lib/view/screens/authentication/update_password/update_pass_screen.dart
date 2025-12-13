import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class UpdatePassScreen extends StatelessWidget {
  const UpdatePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

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
                    text: "Set a New password",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),

                  ),
                ),
                const SizedBox(height: 25),

                // New Password
                const CustomText(
                  text: "New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey_04,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: newPasswordController,
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                const SizedBox(height: 20),
                // Confirm New Password
                const CustomText(
                  text: "Confirm New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey_04,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: confirmPasswordController,
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),
                const SizedBox(height: 25),

                // Update Password Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButtonTwo(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    borderRadius: 16,
                    textColor: AppColors.white,
                    fillColor: AppColors.primary,
                    title: "Update Password",
                    fontSize: 18,
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