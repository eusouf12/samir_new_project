import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';

import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_button/custom_button_two.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../controller/deals_controller.dart';

class HostReviewConfirmScreen extends StatelessWidget {
  HostReviewConfirmScreen({super.key});
  final DealsController dealsController = Get.put(DealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Review & Confirm"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //linear progressbar
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
                    text: "Step 4 of 4",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 6,
                  ),
                  CustomText(
                    text: "Review & Confirm",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    bottom: 6,
                  ),
                  LinearProgressIndicator(
                    value: 1,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                    backgroundColor: AppColors.greyLight,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                        CustomText(
                          text: "Deal Title",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          bottom: 8,
                        ),
                        CustomText(
                          text: "${dealsController.selectedTitle}",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          bottom: 8,
                        ),
                        Divider(thickness: 1, color: AppColors.textClr.withValues(alpha: .2)),
                        // Deliverables
                        CustomText(
                          top: 6,
                          text: "Deliverables",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          bottom: 8,
                        ),
                        Obx(() {
                          if (dealsController.deliverables.isEmpty) {
                            return const Text("No deliverables selected.", style: TextStyle(color: Colors.grey),);
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dealsController.deliverables.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: CustomText(
                                  text:
                                  "${item['quantity']} ${item['platform']} ${item['contentType']}${item['quantity'] > 1 ? 's' : ''}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textClr,
                                  bottom: 6,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        Divider(thickness: 1, color: AppColors.textClr.withValues(alpha: .2),),
                        //Offers
                        CustomText(
                          top: 6,
                          text: "Offers",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          bottom: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Cash Payment",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "\$${dealsController.paymentAmount}",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Night Stay",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "${dealsController.totalNights} nights",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                        CustomText(
                          text: "Campaign Details",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          bottom: 8,
                        ),
                        //Duration
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Duration",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            Obx(() {
                              final checkIn = dealsController.checkInDate.value;
                              final checkOut = dealsController.checkOutDate.value;

                              String durationText = "Select dates";
                              if (checkIn != null && checkOut != null) {
                                final duration = checkOut.difference(checkIn).inDays;
                                durationText = "$duration day${duration > 1 ? 's' : ''}";
                              }

                              return CustomText(
                                text: durationText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              );
                            }),
                          ],
                        ),

                        SizedBox(height: 8,),
                        Column(
                          children: [
                            Obx(() {
                              final checkIn = dealsController.checkInDate.value;
                              String checkInText = "Select date";
                              if (checkIn != null) {
                                checkInText =
                                "${checkIn.day.toString().padLeft(2,'0')} ${_monthName(checkIn.month)}, ${checkIn.year}";
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Check-in",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textClr,
                                  ),
                                  CustomText(
                                    text: checkInText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 8),
                            Obx(() {
                              final checkOut = dealsController.checkOutDate.value;
                              String checkOutText = "Select date";
                              if (checkOut != null) {
                                checkOutText =
                                "${checkOut.day.toString().padLeft(2,'0')} ${_monthName(checkOut.month)}, ${checkOut.year}";
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Check-out",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textClr,
                                  ),
                                  CustomText(
                                    text: checkOutText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),

                       SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Guests",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            Obx(() => CustomText(
                              text: "${dealsController.guestCount.value} ${dealsController.guestCount.value == 1 ? 'Guest' : 'Guests'}",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                          ],
                        )


                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Obx((){
                    return dealsController.isCreatingDeal.value
                        ? CustomLoader()
                        : CustomButton(
                       onTap: () async {
                        await dealsController.createDeal();
                      },
                      title: "Publish Deal",
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

}
