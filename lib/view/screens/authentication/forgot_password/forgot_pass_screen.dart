import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailPhoneController = TextEditingController();

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

                const SizedBox(height: 140),

                // Title
                Center(
                  child: CustomText(
                    text: "Forget Password",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                    //letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Description
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: "Enter your registered email or phone number and we'll send you a link to reset your password.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Email / Phone
                const CustomText(
                  text: "Email Address/ Phone Number",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: emailPhoneController,
                  hintText: "Enter Your Email Or Phone",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF9CA3AF), size: 20),
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25),
                // Send Button
                CustomButtonTwo(
                  onTap: () {
                    Get.toNamed(AppRoutes.verifyOtpScreen);
                  },
                  borderRadius: 16,
                  textColor: AppColors.white,
                  fillColor: AppColors.primary,
                  title: "Send",
                  fontSize: 18,
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CustomText(
                      text: "Back To LogIn",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}