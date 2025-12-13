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

class RegistrationScreen extends StatelessWidget {
  final controller = Get.put(AuthController());
  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailPhoneController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                const Center(
                  child: CustomText(
                    text: "HOSTINFLU",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    bottom: 10,
                  ),
                ),
                CustomText(
                  text: "Join the platform connecting hosts and influencers",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textClr,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 32),

                // Login/Register Toggle
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => GestureDetector(
                          onTap: () {
                            controller.toggleTab(true);
                            Get.find<AuthController>().toggleTab(true);
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: controller.isLoginSelected.value
                                  ? AppColors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: controller.isLoginSelected.value
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
                                text: "Login",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: controller.isLoginSelected.value
                                    ? AppColors.primary
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        )),
                      ),
                      Expanded(
                        child: Obx(() => GestureDetector(
                          onTap: () {
                            controller.toggleTab(false);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: !controller.isLoginSelected.value
                                  ? AppColors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
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
                                color: !controller.isLoginSelected.value
                                    ? AppColors.primary
                                    : AppColors.grey_02,
                              ),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Full Name
                const CustomText(
                  text: "Full Name",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textClr
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: nameController,
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                const SizedBox(height: 20),
                // Email / Phone
                const CustomText(
                  text: "Email Address / Phone Number",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textClr,
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

                const SizedBox(height: 20),
                // Location
                CustomText(
                  text: 'Location',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textClr,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: locationController,
                  hintText: "Location",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  suffixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF9CA3AF), size: 24),
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                const SizedBox(height: 20),
                // Password
                const CustomText(
                  text: "Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textClr,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: passwordController,
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: AppColors.textClr, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                const SizedBox(height: 20),
                // Confirm Password
                const CustomText(
                  text: "Confirm Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey_04,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  textEditingController: confirmPasswordController,
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: AppColors.grey_04, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButtonTwo(
                    onTap: () {
                       Get.toNamed(AppRoutes.forgotPassScreen);
                    },
                    borderRadius: 16,
                    textColor: AppColors.white,
                    fillColor: AppColors.primary,
                    title: "SignUp",
                    fontSize: 18,
                  ),
                ),

               /* const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomText(
                        text: "signUp With",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey_04,
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
                  ],
                ),
*/
                const SizedBox(height: 22),
        /*        Row(
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
                          child: Center(
                            child: CustomImage(imageSrc: AppImages.google, height: 20, width: 20),
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
                          child: const Center(
                            child: CustomImage(imageSrc: AppImages.appleIcon, height: 24, width: 24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/

               /* const SizedBox(height: 22),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: const CustomText(
                      text: "continue As Guest",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                ),
*/
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
