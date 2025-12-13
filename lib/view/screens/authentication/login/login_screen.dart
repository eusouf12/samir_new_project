import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_images/app_images.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Column(
                  children: [
                    CustomText(
                      text: "HOSTINFLU",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text: "Connect. Collaborate. Grow.",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Obx(() =>
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.toggleTab(true),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: controller.isLoginSelected.value ? AppColors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow:controller.isLoginSelected.value
                                    ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                    : null,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "Login",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: controller.isLoginSelected.value
                                      ? AppColors.primary
                                      : AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.toggleTab(false);
                              Get.toNamed(AppRoutes.registrationScreen);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: !controller.isLoginSelected.value ? AppColors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: !controller.isLoginSelected.value
                                    ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                    : null,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "Register",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color:  !controller.isLoginSelected.value
                                      ? AppColors.primary
                                      : AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              const SizedBox(height: 32),
              //  Email Field
              const CustomText(
                text: "Email Address",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.grey_04,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                textEditingController: emailController,
                hintText: "Enter your email",
                hintStyle: TextStyle(
                    color: AppColors.grey_02,
                    fontSize: 14
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF9CA3AF),
                  size: 20,),
                fillColor: AppColors.white,
                fieldBorderColor: const Color(0xFFE5E7EB),
                fieldBorderRadius: 12,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Password Field
              const CustomText(
                text: "Password",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.grey_04,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                textEditingController: passwordController,
                hintText: "Enter your password",
                hintStyle: TextStyle(
                    color: AppColors.grey_02,
                    fontSize: 14
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF9CA3AF),
                  size: 22,
                ),
                isPassword: true,
                fillColor: AppColors.white,
                fieldBorderColor: const Color(0xFFE5E7EB),
                fieldBorderRadius: 12,
              ),
              const SizedBox(height: 14),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotPassScreen);
                  },
                  child: const CustomText(
                    text: "Forgot Password?",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              //  Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: CustomButtonTwo(
                  onTap: () {
                    // Handle login
                  },
                  borderRadius: 16,
                  textColor: AppColors.white,
                  fillColor: AppColors.primary,
                  title: "Login",
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(
                      text: "or Continue With",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              // Social Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: CustomImage(imageSrc: AppImages.google, height: 20,width: 20,)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: CustomImage(imageSrc: AppImages.appleIcon, height: 24,width: 24,)),),),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Register redirect
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "Don't have an account",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        controller.toggleTab(false);
                        Get.toNamed(AppRoutes.registrationScreen);
                      },
                      child: const CustomText(
                        text: "Register",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}