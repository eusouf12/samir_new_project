import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../authentication/controller/auth_controller.dart';

class AccountReadyScreen extends StatelessWidget {
  AccountReadyScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        authController.loginLoading.value = true;
        Get.offNamed(AppRoutes.loginScreen);
      });
    });
    return CustomGradient(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.accountReady,
                  height: 320.h,
                  width: 320.w,
                ),
              ],
            ),
          ),
        )
    );
  }
}