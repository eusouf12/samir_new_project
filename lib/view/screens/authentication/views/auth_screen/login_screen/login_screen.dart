import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../controller/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   authController.toggleTab(true);
    // });
    return CustomGradient(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24,top:50,  bottom: 20),
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
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // toggle btn
                  Obx(() =>
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.white),
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => authController.toggleTab(true),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: authController.isLoginTab.value ? AppColors.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow:authController.isLoginTab.value
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
                                      text: "Sign In",
                                      fontWeight: FontWeight.w500,
                                      color: authController.isLoginTab.value
                                          ? AppColors.white
                                          : AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // create Account
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  authController.toggleTab(false);
                                  Get.toNamed(AppRoutes.signUpScreen);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: !authController.isLoginTab.value ? AppColors.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: !authController.isLoginTab.value
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
                                      text: "Create Account",
                                      fontWeight: FontWeight.w500,
                                      color:  !authController.isLoginTab.value
                                          ? AppColors.white
                                          : AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),),
                  SizedBox(height: 30),
                  //  Email &  Password Field
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Email
                        CustomText(
                          text: "Email or User Name",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: authController.loginEmailController.value,
                          hintText: AppStrings.enterYourEmail,
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 20,),
                          fillColor: AppColors.white,
                          fieldBorderColor: const Color(0xFFE5E7EB),
                          fieldBorderRadius: 12,
                          keyboardType: TextInputType.emailAddress,

                        ),
                        SizedBox(height: 20),
                        // Password Field
                        CustomText(
                          text: AppStrings.password,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: authController.loginPasswordController.value,
                          hintText: AppStrings.enterYourPassword,
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  //  Login Button
                  Obx((){
                    return authController.loginUserLoading.value
                        ? CustomLoader()
                        : CustomButton(
                      onTap: () {
                        authController.loginUser();
                      },
                      borderRadius: 12,
                      textColor: AppColors.white,
                      title: "Continue",
                      fillColor: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    );

                  }),
                  SizedBox(height: 50),
                  // Forgot Password
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotScreen);
                      },
                      child:  CustomText(
                        text: AppStrings.forgetPassword,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        )

    );
  }
}
