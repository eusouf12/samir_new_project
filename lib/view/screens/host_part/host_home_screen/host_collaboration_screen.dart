import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_tab_selected/custom_tab_bar.dart';
import 'controller/host_home_controller.dart';

class HostCollaborationScreen extends StatelessWidget {
   HostCollaborationScreen({super.key});

  final hostHomeController = Get.find<HostHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Collaboration"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Manage Requests",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              bottom: 8,
            ),
            CustomText(
              text:
                  "Review requests from influencers who want to collaborate on your listings.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textClr,
              textAlign: TextAlign.start,
              maxLines: 3,
              bottom: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: "15",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: "Total",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomText(
                      text: "3",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffEAB308),
                    ),
                    CustomText(
                      text: "Pending",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomText(
                      text: "9",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff22C55E),
                    ),
                    CustomText(
                      text: "Approved",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomText(
                      text: "9",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffEF4444),
                    ),
                    CustomText(
                      text: "Declined",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Obx(() => CustomTabBar(
              textColor: AppColors.white,
              tabs: hostHomeController.collaborationTabList,
              selectedIndex: hostHomeController.currentIndex.value,
              onTabSelected: (value) {
                hostHomeController.currentIndex.value = value;

                if (value == 0) {

                } else if (value == 1) {

                } else if (value == 2) {
                }
              },
              selectedColor: AppColors.primary,
            )),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppConstants.girlsPhoto,
                          height: 64,
                          width: 64,
                          boxShape: BoxShape.circle,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Sarah Anderson",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: "@sarahtravels",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: List.generate(3, (value) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffECFEFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: "Travel",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.home,size: 24,color: AppColors.textClr,),
                        CustomText(text: "Luxury Beach Villa - Malibu",fontSize: 14,fontWeight: FontWeight.w500,)
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: CustomButtonTwo(
                            height: 40,
                            onTap: () {
                              Get.toNamed(AppRoutes.hostCollaborationViewDetailsScreen);
                            },
                            title: "View Details",
                            fontSize: 12,
                            borderRadius: 10,
                            isBorder: true,
                            fillColor: AppColors.white,
                            textColor: AppColors.black_02,
                            borderWidth: 1,
                            borderColor: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Flexible(
                          flex: 2,
                          child: CustomButtonTwo(
                            height: 40,
                            onTap: () {
                              Get.toNamed(AppRoutes.hostSendCollaboarationScreen);
                            },
                            title: "Approve",
                            fontSize: 12,
                            borderRadius: 10,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Flexible(
                          flex: 1,
                          child: CustomButtonTwo(
                            height: 40,
                            fillColor: AppColors.red_02,
                            onTap: () {
                              Get.toNamed(AppRoutes.hostSendCollaboarationScreen);
                            },
                            title: "X",
                            textColor: AppColors.white,
                            fontSize: 12,
                            borderRadius: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppConstants.girlsPhoto,
                          height: 64,
                          width: 64,
                          boxShape: BoxShape.circle,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Sarah Anderson",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: "@sarahtravels",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: List.generate(3, (value) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffECFEFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: "Travel",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.home,size: 24,color: AppColors.textClr,),
                        CustomText(text: "Luxury Beach Villa - Malibu",fontSize: 14,fontWeight: FontWeight.w500,)
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: CustomButtonTwo(
                            height: 40,
                            onTap: () {
                              // Get.toNamed(AppRoutes.hostActiveViewProfileScreen);
                            },
                            title: "View Details",
                            fontSize: 12,
                            borderRadius: 10,
                            isBorder: true,
                            fillColor: AppColors.white,
                            textColor: AppColors.black_02,
                            borderWidth: 1,
                            borderColor: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Flexible(
                          flex: 2,
                          child: CustomButtonTwo(
                            height: 40,
                            onTap: () {
                              Get.toNamed(AppRoutes.hostSendCollaboarationScreen);
                            },
                            title: "Approve",
                            fontSize: 12,
                            borderRadius: 10,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Flexible(
                          flex: 1,
                          child: CustomButtonTwo(
                            height: 40,
                            fillColor: AppColors.red_02,
                            onTap: () {
                              Get.toNamed(AppRoutes.hostSendCollaboarationScreen);
                            },
                            title: "X",
                            textColor: AppColors.white,
                            fontSize: 12,
                            borderRadius: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
