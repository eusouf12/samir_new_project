import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../choose_role/view/role_screen.dart';
import '../../../controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.toggleTab(false);
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24 , top: 50,  bottom: 20),
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
                              // onTap: () => authController.toggleTab(true),
                              onTap: () {
                                authController.toggleTab(true);
                                Get.to(() => LoginScreen());
                              },
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
                                authController.toggleTab(true);
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
                    ),
                ),

                // middle container
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                      key: formKey,
                    child: Obx(()=>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Full Name",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                                textEditingController: authController.nameController.value,
                                hintText: "Enter your name",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                prefixIcon: const Icon(Icons.person_outlined, color: Color(0xFF9CA3AF), size: 20,),
                                fillColor: AppColors.white,
                                fieldBorderColor: const Color(0xFFE5E7EB),
                                fieldBorderRadius: 12,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your name';
                                  }
                                  return null;
                                }
                            ),
                            // userName
                            CustomText(
                              text: "User Name",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              top: 10,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                                textEditingController: authController.usernameController.value,
                                hintText: "Enter your user name",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                prefixIcon: const Icon(Icons.person_outlined, color: Color(0xFF9CA3AF), size: 20,),
                                fillColor: AppColors.white,
                                fieldBorderColor: const Color(0xFFE5E7EB),
                                fieldBorderRadius: 12,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your User Name';
                                  }
                                  return null;
                                }

                            ),
                            SizedBox(height: 10),
                            //Email
                            CustomText(
                              text: AppStrings.email,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                                textEditingController: authController.emailController.value,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your email';
                                  }
                                  return null;
                                }

                            ),
                            //Location
                            CustomText(
                              text: "Location",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                                textEditingController: authController.locationController.value,
                                hintText: "Enter your location",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                prefixIcon: Icon(Icons.location_on_outlined,
                                  color: Color(0xFF9CA3AF),
                                  size: 20,),
                                fillColor: AppColors.white,
                                fieldBorderColor: const Color(0xFFE5E7EB),
                                fieldBorderRadius: 12,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your location';
                                  }
                                  return null;
                                }

                            ),
                            // Password Field
                            CustomText(
                              text: AppStrings.password,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              textEditingController: authController.passwordController.value,
                              hintText: "Create a strong password",
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
                              onChanged: (value) {
                                authController.validatePasswordLive(value);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Your Password';
                                }

                                if (authController.passwordError.value.isNotEmpty) {
                                  return authController.passwordError.value;
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            // confirmPassword
                            CustomText(
                              text: AppStrings.changePassword,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              textEditingController:  authController.confirmPasswordController.value,
                              hintText: "Retype password",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password';
                                } else if (value !=
                                    authController.passwordController.value.text) {
                                  return 'Password not Match';

                                }
                                return null;
                              },
                            ),
                          ],
                        )
                    )

                  ),
                ),
                SizedBox(height: 20),
                //  Create Account Button
                 CustomButton(
                    onTap: () {
                      if(formKey.currentState!.validate())
                        {
                          Get.to(() =>  ChooseRole());
                        }
                    },
                    borderRadius: 12,
                    textColor: AppColors.white,
                    title: "Create Account",
                    fillColor: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}