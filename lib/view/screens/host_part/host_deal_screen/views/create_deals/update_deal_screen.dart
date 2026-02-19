import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../controller/deals_controller.dart';


class HostUpdateDealScreen extends StatelessWidget {
  HostUpdateDealScreen({super.key});

  final DealsController controller = Get.put(DealsController());
  final String dealId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(titleName: "Update Deal",leftIcon: true,),
        body: Obx(() {
          if (controller.rxSingleDealStatus.value == Status.loading) {
            return  Center(child: CustomLoader());
          }
      
          if (controller.singleDealList.isEmpty) {
            return const Center(child: Text("Deal not found"));
          }
      
          final deal = controller.singleDealList.first;
      
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                // ================= Night Stay =================
                CustomText(text: "Night Stay",fontSize: 16,fontWeight: FontWeight.w600,),
                _stepper(
                  value: controller.updateNights,
                  onMinus: () {
                    if (controller.updateNights.value > 1) {
                      controller.updateNights.value--;
                    }
                  },
                  onPlus: () => controller.updateNights.value++,
                ),
      
                SizedBox(height: 20),
      
                // ================= Guests =================
                CustomText(text: "Guests",fontSize: 16,fontWeight: FontWeight.w600,),
                _stepper(
                  value: controller.updateGuest,
                  onMinus: () {
                    if (controller.updateGuest.value > 1) {
                      controller.updateGuest.value--;
                    }
                  },
                  onPlus: () => controller.updateGuest.value++,
                ),
      
                const SizedBox(height: 20),
      
                // ================= Payment =================
                CustomText(text: "Payment Amount",fontSize: 16,fontWeight: FontWeight.w600,),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    prefixText: "\$ ",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppColors.primary.withValues(alpha: 0.5)
                      ),
                    ),
                  ),
                  onChanged: (v) {
                    controller.updatePaymentAmount.value = double.tryParse(v) ?? 0.0;
                  },
                  controller: TextEditingController(
                    text: controller.updatePaymentAmount.value.toString(),
                  ),
                ),
      
                const SizedBox(height: 24),
      
                // ================= Deliverables =================
                CustomText(text: "Deliverables",fontSize: 16,fontWeight: FontWeight.w600,),
                SizedBox(height: 10),
                Column(
                  children: deal.deliverables.map((d) {
                    final key = "${d.platform}_${d.contentType}";
      
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${d.platform} • ${d.contentType}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
      
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              final current =
                                  controller.updateDeliverableQty[key] ??
                                      d.quantity;
                              if (current > 1) {
                                controller.updateDeliverableQty[key] =
                                    current - 1;
                              }
                            },
                          ),
      
                          Obx(() => Text(
                            "${controller.updateDeliverableQty[key] ?? d.quantity}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
      
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              final current =
                                  controller.updateDeliverableQty[key] ??
                                      d.quantity;
                              controller.updateDeliverableQty[key] =
                                  current + 1;
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24),
                // ================= Minimum Followers =================
                CustomText(text: "Minimum Followers (Platform wise)",fontSize: 16,fontWeight: FontWeight.w600,),
                SizedBox(height: 10),
                Column(
                  children: deal.deliverables.map((d) => d.platform).toSet().map((platform) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              platform,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Obx(() {
                              return TextField(
                                decoration:  InputDecoration(
                                  hintText: "e.g. 10k, 100k",
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: AppColors.primary.withValues(alpha: 0.5)
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: controller.updatePlatformFollowers[platform] ?? deal.deliverables.firstWhere((e) => e.platform == platform).platformFollowers[platform] ?? "",
                                ),
                                onChanged: (val) {
                                  controller.updatePlatformFollowers[platform] = val.trim();
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
      
                SizedBox(height: 30),
                // btn
                Obx(() {
                  return controller.isUpdateListingLoading.value
                      ?  Center(child: CustomLoader())
                      : CustomButton(
                    title: "Update Deal",
                    onTap: () =>
                        controller.updateDeal(dealId: dealId),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// ================= Helpers =================

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _stepper({
    required RxInt value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Obx(() => Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: onMinus,
        ),
        Text(
          "${value.value}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: onPlus,
        ),
      ],
    ));
  }
}