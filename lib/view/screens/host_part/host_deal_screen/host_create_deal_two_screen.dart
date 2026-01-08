import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/deals_controller.dart';

class HostCreateDealTwoScreen extends StatelessWidget {
  HostCreateDealTwoScreen({super.key});

  final DealsController controller = Get.put(DealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomRoyelAppbar(leftIcon: true, titleName: "Create Deal"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Select Platform", fontSize: 14, fontWeight: FontWeight.w500, bottom: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: controller.platformNames.map((p) => _buildChoiceChip(p)).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const CustomText(text: "Content Type", fontSize: 14, fontWeight: FontWeight.w500, bottom: 8),
                  _buildDropdown(),

                  const SizedBox(height: 20),

                  const CustomText(text: "How many contents should they create?", fontSize: 14, fontWeight: FontWeight.w500, bottom: 8),
                  Row(
                    children: [
                      _stepButton(Icons.remove, () => controller.decrement()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() => CustomText(text: "${controller.quantity.value}", fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      _stepButton(Icons.add, () => controller.increment()),
                      const Spacer(),

                      ElevatedButton(
                        onPressed: () => controller.addDeliverable(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffa8e3d0),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Add Deliverable"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const Divider(),
                  const CustomText(text: "Added Deliverables", fontSize: 16, fontWeight: FontWeight.bold, top: 10, bottom: 12),

                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.deliverables.length,
                    itemBuilder: (context, index) {
                      final item = controller.deliverables[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            CustomText(text: "${item['platform']}  •  ${item['contentType']}", fontSize: 15, fontWeight: FontWeight.w500),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                              child: Text("x${item['quantity']}", style: const TextStyle(fontSize: 12)),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => controller.removeDeliverable(index),
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 22),
                            )
                          ],
                        ),
                      );
                    },
                  )),

                  const SizedBox(height: 40),
                  CustomButtonTwo(
                    onTap: () {
                      debugPrint("==== SELECTED DELIVERABLES ====");

                      for (var item in controller.deliverables) {
                        debugPrint(item.toString());
                      }

                      Get.toNamed(AppRoutes.hostCreateDealThreeScreen);
                    },
                    title: "Next →",
                  ),


                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xffeff9f8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: "Step 2 of 4", fontSize: 14, color: AppColors.primary, bottom: 6),
          const CustomText(text: "Deliverables", fontSize: 16, fontWeight: FontWeight.w700, bottom: 6),
          LinearProgressIndicator(
            value: 0.50,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary,
            backgroundColor: AppColors.greyLight,
          )
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    return Obx(() {
      final bool isActive = label == controller.selectedPlatform.value;

      final Color iconColor =
          controller.platformColors[label] ?? Colors.grey;

      return GestureDetector(
        onTap: () => controller.selectedPlatform.value = label,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300,),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                controller.platformIcons[label], size: 32, color: iconColor,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isActive
                      ? Colors.white
                      : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
          value: controller.selectedContentType.value,
          isExpanded: true,
          onChanged: (val) => controller.selectedContentType.value = val!,
          items: controller.contentTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        )),
      ),
    );
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: const Color(0xff48C192), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}