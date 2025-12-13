import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';

class HostReviewConfirmScreen extends StatelessWidget {
  const HostReviewConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Review & Confirm"),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        CustomText(
                          text: "Luxury Beach Villa Content Creation",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          bottom: 8,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.textClr.withValues(alpha: .2),
                        ),
                        CustomText(
                          top: 6,
                          text: "Selected Listing",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppConstants.girlsPhoto,
                              height: 50,
                              width: 50,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Oceanview Villa Malibu",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text: "Malibu, California",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.textClr.withValues(alpha: .2),
                        ),
                        CustomText(
                          top: 6,
                          text: "Deliverables",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        CustomText(
                          text: "5 Youtube Posts",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        CustomText(
                          text: "2 Instagram Posts",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        CustomText(
                          text: "2 TikTok Videos",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 6,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.textClr.withValues(alpha: .2),
                        ),
                        CustomText(
                          top: 6,
                          text: "Offers",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
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
                              text: "\$2,500",
                              fontSize: 18,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "3 nights",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textClr,
                          bottom: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Duration",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "7 days",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Check-in",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "Dec 15, 2024",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Check-out",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textClr,
                            ),
                            CustomText(
                              text: "Dec 15, 2024",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
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
                            CustomText(
                              text: "2 adults",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomButtonTwo(
                    onTap: () {
                      Get.toNamed(AppRoutes.hostHomeScreen);
                    },
                    title: "Publish Deal",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
