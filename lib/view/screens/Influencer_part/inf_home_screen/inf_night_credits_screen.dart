import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:get/get.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/inf_home_controller.dart';

class InfNightCreditsScreen extends StatelessWidget {
  InfNightCreditsScreen({super.key});

  final InfHomeController controller = Get.put(InfHomeController());

  String formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat("MMM dd, yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserGifts();
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Night Credits History",),
      body: Obx(() {

        if (controller.isGiftsLoading.value) {
          return Center(child: CustomLoader(color: AppColors.primary2),);
        }

        final list = controller.giftsData.value?.gifts ?? [];

        if (list.isEmpty) {
          return const Center(child: Text("No Night Credits Found"),);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final details = item.collaborationDetails;

            final isCompleted = details.status.toLowerCase() == "completed";

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F3F5)),
                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    // ===== Left Section =====
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                            item.collaborationTitle,
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w600,
                            bottom: 6,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text:
                            formatDate(item.receivedAt),
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w400,
                            color:
                            AppColors.textClr,
                            bottom: 10,
                          ),
                          CustomText(
                            text: "Earned",
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w400,
                            color:
                            AppColors.textClr,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // ===== Right Section =====
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isCompleted ? const Color(0xffDCFCE7) : const Color(0xffFEE2E2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CustomText(
                            text: details.status.capitalizeFirst ?? "",
                            fontSize: 12, fontWeight: FontWeight.w600,
                            color: isCompleted ? AppColors.green : Colors.red,
                          ),
                        ),
                        CustomText(
                          top: 14,
                          text: "+${item.starsReceived} Night Credits",
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w500,
                          color:
                          AppColors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
