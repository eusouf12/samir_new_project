import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../controller/collabration_controller.dart';

class NegotiationScreen extends StatelessWidget {
  NegotiationScreen({super.key});

  final CollaborationController controller = Get.find<CollaborationController>();
  final args = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final String collId = args["collaborationId"] ?? "";
    final String role = args["role"] ?? "";
    final String negotiationMessage = args["negotiationMessage"] ?? "";
    final String influencerId = args["influencerId"] ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedCollaboration.value = null;
      controller.setSelectedCollaboration(collId);
      controller.getSingleUser(userId: influencerId);
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Negotiation Details",
          leftIcon: true,
        ),
        body: Obx(() {
          final coll = controller.selectedCollaboration.value;
          final infNightCredits = controller.singleUserProfile.value?.nightCredits ?? 0;
          controller.maxNightCredits = infNightCredits;

          if (coll == null) {
            return  Center(child: CustomLoader());
          }

          final deliverables = coll.deliverables ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Night Stay and Guest ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildModernStepperRow(
                        label: "Night Stay",
                        icon: Icons.nightlight_round,
                        value: controller.updateNightsColl,
                        onMinus: controller.decrementNight,
                        onPlus: controller.incrementNight,
                        role: role,
                      ),
                      const Divider(height: 32),
                      _buildModernStepperRow(
                        label: "Number of Guests",
                        icon: Icons.people_alt_rounded,
                        value: controller.updateGuestColl,
                        onMinus: () => controller.updateGuestColl.value > 1 ? controller.updateGuestColl.value-- : null,
                        onPlus: () => controller.updateGuestColl.value++, role: role,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Payment Amount ---
                const CustomText(text: "Compensation", fontSize: 16, fontWeight: FontWeight.w700, bottom: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller.paymentController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money_rounded, color: role =='host'? AppColors.primary : AppColors.primary2),
                      hintText: "0.00",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color:role == 'host'? AppColors.primary : AppColors.primary2, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      controller.updatePaymentAmountColl.value = double.tryParse(value) ?? 0.0;
                    },
                  ),
                ),
                const SizedBox(height: 24),

                /// --- Deliverables ---
                const CustomText(text: "Deliverables List", fontSize: 16, fontWeight: FontWeight.w700, bottom: 12),
                ...deliverables.map((d) {
                  final key = "${d.platform}_${d.contentType}";
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      children: [
                        // Icon representation based on platform
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Icon(_getPlatformIcon(d.platform ?? ""), size: 20, color: role =='host'? AppColors.primary : AppColors.primary2),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.platform ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text(d.contentType ?? "", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                        _smallStepper(
                          onMinus: () {
                            final current = controller.updateDeliverableQtyColl[key] ?? d.quantity ?? 1;
                            if (current > 1) controller.updateDeliverableQtyColl[key] = current - 1;
                          },
                          onPlus: () {
                            final current = controller.updateDeliverableQtyColl[key] ?? d.quantity ?? 1;
                            controller.updateDeliverableQtyColl[key] = current + 1;
                          },
                          valueWidget: Obx(() => Text(
                            "${controller.updateDeliverableQtyColl[key] ?? d.quantity}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                // ===== write your reason =========
                const SizedBox(height: 24),
                const CustomText(text: "Reason for Negotiation", fontSize: 16, fontWeight: FontWeight.w700, bottom: 12),
                CustomTextField(
                  textEditingController: controller.reasonController.value,
                  hintText: "Write your reason here....",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  maxLines: 5,
                  fieldFocusBorderColor: role== 'host'? AppColors.primary : AppColors.primary2,
                  fieldBorderColor:  Colors.grey.shade400,
                  fillColor: Colors.transparent,
                ),

                const SizedBox(height: 40),

                // --- Submit Button ---
                Obx(() => controller.isUpdateCollLoading.value
                    ?  Center(child: CustomLoader())
                    : CustomButton(
                  title: "Update Collaboration",
                  fillColor: role =='host'? AppColors.primary : AppColors.primary2,
                  onTap: () => controller.updateCollabration(collId: collId),
                )),
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Modern Row for Stepper
  Widget _buildModernStepperRow({
    required String label,
    required IconData icon,
    required RxInt value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
    required String role,
  }) {
    return Row(
      children: [
        Icon(icon, color:role =='host'? AppColors.primary : AppColors.primary2, size: 22),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
        _smallStepper(onMinus: onMinus, onPlus: onPlus,
            valueWidget: Obx(() => Text("${value.value}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
        ),
      ],
    );
  }

  // Reusable Rounded Stepper Widget
  Widget _smallStepper({required VoidCallback onMinus, required VoidCallback onPlus, required Widget valueWidget}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(onPressed: onMinus, icon: const Icon(Icons.remove, size: 18), splashRadius: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: valueWidget),
          IconButton(onPressed: onPlus, icon: const Icon(Icons.add, size: 18), splashRadius: 20),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram': return Icons.camera_alt_outlined;
      case 'facebook': return Icons.facebook_outlined;
      case 'youtube': return Icons.play_circle_outline;
      case 'tiktok': return Icons.music_note_outlined;
      default: return Icons.link;
    }
  }
}