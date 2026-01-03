import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../../utils/local_storage/local_storage.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../authentication/controller/auth_controller.dart';
import '../custom_role/custom_role.dart';

class RoleController extends GetxController {
  RxString selectedRole = ''.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  bool get isSelected => selectedRole.isNotEmpty;
}


class ChooseRole extends StatelessWidget {
  final authController = Get.put(AuthController());
  final roleController = Get.put(RoleController());
  ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              const SizedBox(height: 20),
              const Center(
                child: CustomText(
                  text: "HOSTINFLU",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: CustomText(
                    text: "Choose your role",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black
                ),
              ),
              const Center(
                child: CustomText(
                    top: 10,
                    text: "Select how you want to use Hostinflu",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(height: 80),
              Expanded(
                child:Obx(()=> ListView(
                  children: [
                    CustomRole(
                      icon: AppImages.home,
                      title: "Host",
                      description: "List your property and collaborate with influencers",
                      isSelected: roleController.selectedRole.value == "host",
                      onTap: () {
                        roleController.selectRole("host");
                        debugPrint("Chose Role host========================================${roleController.selectedRole.value}");
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomRole(
                      icon: AppImages.camara,
                      title: "Influencer",
                      description: "Promote listings and earn through collaborations",
                      isSelected: roleController.selectedRole.value == "influencer",
                      onTap: () {
                        roleController.selectRole("influencer");
                        debugPrint("Chose Role host========================================${roleController.selectedRole.value}");
                      },
                    ),
                  ],
                ),)
              ),
              Obx((){
                return authController.signUpLoading.value
                    ? CustomLoader()
                    : CustomButton(
                  onTap: () {
                    StorageService().write("role", roleController.selectedRole.value);
                    final role = StorageService().read<String>("role");
                    debugPrint("Chose Role host========================================${role}");
                    authController.signUp();
                  },
                  borderRadius: 12,
                  textColor:roleController.isSelected? AppColors.white : AppColors.black,
                  title: "Create Account",
                  fillColor: roleController.isSelected ? AppColors.primary : Colors.grey.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                );
              }),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Already have an account ?  ',
                    fontSize: 16.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_02,
                  ),
                  GestureDetector(
                    onTap: () {
                      authController.loginLoading.value = true;
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: CustomText(
                      text: 'Log in',
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}