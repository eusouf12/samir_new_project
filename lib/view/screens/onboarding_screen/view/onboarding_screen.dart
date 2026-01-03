import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: controller.skipOnboarding,
              child: CustomText(
                text: "Skip",
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                left: 300,
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingPage1(),
                  OnboardingPage2(),
                  OnboardingPage3(),
                ],
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: controller.currentPage.value == index ? 40 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? AppColors.primary
                        : const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            )),
            const SizedBox(height: 40),

            // Dynamic title and subtitle text based on page index
            Obx(() {
              String title = "";
              String subtitle = "";
              if (controller.currentPage.value == 0) {
                title = "Collaborate with ease";
                subtitle = "Connect hosts and creators for seamless Airbnb collaborations.";
              } else if (controller.currentPage.value == 1) {
                title = "Grow your Airbnb visibility";
                subtitle = "Boost your listing reach with the right influencer partnership.";
              } else if (controller.currentPage.value == 2) {
                title = "Earn with influence";
                subtitle = "Get rewarded for creating authentic travel content.";
              }
              return Column(
                children: [
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomText(
                      text: subtitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.textClr,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: 306,
                    height: 46,
                    child: CustomButtonTwo(
                      onTap: () {
                        controller.nextPage();
                      },
                      borderRadius: 16,
                      textColor: AppColors.white,
                      title: "Next",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: CustomImage(
                imageSrc: AppImages.onboarding1,
                height: 288,
                width: 288,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: CustomImage(
              imageSrc: AppImages.onboarding2,
              height: 313,
              width: 288,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: CustomImage(
                imageSrc: AppImages.onboarding3,
                height: 250,
                width: 250,
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}