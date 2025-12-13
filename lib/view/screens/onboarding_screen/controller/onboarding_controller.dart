import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../choose_role/view/choose_role.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to Choose Role screen when onboarding is complete
      Get.to(() => const ChooseRole());
    }
  }

  void skipOnboarding() {
    Get.to(() => const ChooseRole());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}