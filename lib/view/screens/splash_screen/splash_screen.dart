// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_text/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
         Get.offAllNamed(AppRoutes.onboardingScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CustomImage(imageSrc: AppIcons.logo)),
          Center(
            child: CustomText(
              top: 20.h,
              text: "HOSTINFLU",
              fontSize: 36.w,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              bottom: 8,
            ),
          ),
          Container(
            height: 6,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          CustomText(
            top: 20.h,
            text: "Connect. Collaborate. Grow.",
            fontSize: 20.w,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ), CustomText(
            top: 8,
            text: "Version 1.0",
            fontSize: 20.w,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
