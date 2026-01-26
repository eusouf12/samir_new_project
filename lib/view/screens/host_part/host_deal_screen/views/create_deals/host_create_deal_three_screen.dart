import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button_two.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../controller/deals_controller.dart';

class HostCreateDealThreeScreen extends StatelessWidget {
  HostCreateDealThreeScreen({super.key});

  final DealsController controller = Get.put(DealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Create Deal"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Step 3 of 4",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                bottom: 6,
              ),
              CustomText(
                text: "Deliverables",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                bottom: 6,
              ),
              LinearProgressIndicator(
                value: 0.75,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
                backgroundColor: AppColors.greyLight,
              ),
              const SizedBox(height: 24),

              /// Compensation Selection
              const Text(
                "Choose Compensation Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Select how you'd like to compensate the influencer for this collaboration",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),

              Obx(() => Column(
                children: [
                  _buildCompCard(
                    title: "Night Credits",
                    subtitle: "Offer free nights at your property as compensation",
                    isActive: controller.isNightCredits.value,
                    onTap: controller.toggleNightCredits,
                    child: _buildNightsStepper(),
                  ),
                  const SizedBox(height: 16),
                  _buildCompCard(
                    title: "Direct Payment",
                    subtitle: "Pay the influencer a monetary amount",
                    isActive: controller.isDirectPayment.value,
                    onTap: controller.toggleDirectPayment,
                    child: _buildPaymentInput(),
                  ),
                ],
              )),

              const SizedBox(height: 20),

              /// Guest Count
              const Text("Guest Count", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => Row(
                children: [
                  GestureDetector(
                    onTap: controller.decrementGuest,
                    child: _stepButton("-"),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${controller.guestCount.value}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.incrementGuest,
                    child: _stepButton("+"),
                  ),
                ],
              )),

              const SizedBox(height: 50),

              CustomButtonTwo(
                title: "Next →",
                onTap: () {
                  debugPrint("Night Credits: ${controller.isNightCredits.value}");
                  debugPrint("Direct Payment: ${controller.isDirectPayment.value}");
                  debugPrint("Total Nights: ${controller.totalNights.value}");
                  debugPrint("Payment Amount: ${controller.paymentAmount.value}");
                  debugPrint("Guest Count: ${controller.guestCount.value}");
                  debugPrint("==== PLATFORM FOLLOWERS ====");
                  controller.platformFollowers.forEach((platform, followers) {
                    debugPrint("$platform : $followers");
                  });

                  Get.toNamed(AppRoutes.hostReviewConfirmScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Compensation Card
  Widget _buildCompCard({
    required String title,
    required String subtitle,
    required bool isActive,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isActive ? Colors.teal : Colors.grey.shade300, width: isActive ? 2 : 1),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isActive ? Icons.check_circle : Icons.radio_button_off, color: isActive ? Colors.teal : Colors.grey),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            const SizedBox(height: 10),
            child
          ],
        ),
      ),
    );
  }

  /// Night Credits Stepper
  Widget _buildNightsStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(onTap: controller.decrementNights, child: _stepButton("-")),
          Expanded(
            child: Center(
              child: Text("${controller.totalNights.value}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          GestureDetector(onTap: controller.incrementNights, child: _stepButton("+")),
        ],
      ),
    );


  }

  /// Direct Payment Input
  Widget _buildPaymentInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text("\$", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller.paymentController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(border: InputBorder.none, hintText: "0.00"),
            ),
          ),
        ],
      ),
    );

  }

  Widget _stepButton(String text) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    );
  }
}
