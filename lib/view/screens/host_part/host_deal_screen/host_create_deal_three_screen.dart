import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
class HostCreateDealThreeScreen extends StatefulWidget {
  const HostCreateDealThreeScreen({super.key});

  @override
  State<HostCreateDealThreeScreen> createState() => _HostCreateDealThreeScreenState();
}

class _HostCreateDealThreeScreenState extends State<HostCreateDealThreeScreen> {

  String selectedType = "nights";
  int nights = 2;
  final TextEditingController paymentController =
  TextEditingController(text: "0.00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Create Deal"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffeff9f8),
                borderRadius: BorderRadius.circular(12),
              ),
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
                    text: "Payment / Credit",
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose Compensation Type",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Select how you'd like to compensate the influencer for this collaboration",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 24),

                      /// Night Credits Card
                      _buildCompCard(
                        isActive: selectedType == "nights",
                        onTap: () => setState(() => selectedType = "nights"),
                        title: "Night Credits",
                        subtitle: "Offer free nights at your property as compensation",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Number of Nights",
                              style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            _buildStepper(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Direct Payment Card
                      _buildCompCard(
                        isActive: selectedType == "payment",
                        onTap: () => setState(() => selectedType = "payment"),
                        title: "Direct Payment",
                        subtitle: "Pay the influencer a monetary amount",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Payment Amount",
                              style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            _buildCurrencyInput(),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 50,),
                  CustomButtonTwo(onTap: (){
                    Get.toNamed(AppRoutes.hostReviewConfirmScreen);
                  },title: "Next →",)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  /// Card Builder
  Widget _buildCompCard({
    required bool isActive,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? Colors.teal : Colors.grey.shade300,
            width: isActive ? 2 : 1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isActive
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isActive ? Colors.teal : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            child
          ],
        ),
      ),
    );
  }

  /// Stepper
  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _stepBtn(
            "-",
                () {
              setState(() {
                if (nights > 1) nights--;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "$nights",
                    style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("nights",
                      style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),
          ),
          _stepBtn(
            "+",
                () => setState(() => nights++),
          ),
        ],
      ),
    );
  }

  /// Stepper Button
  Widget _stepBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// Currency Input
  Widget _buildCurrencyInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            "\$",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: paymentController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "0.00",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
