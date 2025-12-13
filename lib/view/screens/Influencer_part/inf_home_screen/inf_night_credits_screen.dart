import 'package:flutter/material.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../components/custom_text/custom_text.dart';

class InfNightCreditsScreen extends StatelessWidget {
  const InfNightCreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Night Credits"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: CustomText(
                text: "Credit List",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "City Loft",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    bottom: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: AppColors.primary2,
                        size: 24,
                      ),
                      CustomText(
                        text: "2 Night Credits",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary2,
                      ),
                    ],
                  ),
                  CustomText(
                    top: 8,
                    text: "📍 Aspen, Colorado",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textClr,
                    bottom: 12,
                  ),
                  CustomButtonTwo(
                    onTap: () {},
                    title: "Redeem",
                    fillColor: AppColors.primary2,
                  ),
                ],
              ),
            ),
            CustomText(
              top: 20,
              text: "Credit History",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              bottom: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Ocean View Apartment",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      bottom: 6,
                    ),
                    CustomText(
                      text: "Nov 02, 2025",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Earned",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       color: Color(0xffDCFCE7),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     child: CustomText(
                       text: "Completed",
                       fontSize: 12,
                       fontWeight: FontWeight.w500,
                       color: AppColors.green,
                     ),
                   ),
                   CustomText(
                     top: 16,
                     text: "+2 Nights",
                     fontSize: 14,
                     fontWeight: FontWeight.w600,
                     color: AppColors.green,
                   ),
                 ],
               )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Ocean View Apartment",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      bottom: 6,
                    ),
                    CustomText(
                      text: "Nov 02, 2025",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Earned",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffDBEAFE),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: CustomText(
                        text: "Approved",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1D4ED8),
                      ),
                    ),
                    CustomText(
                      top: 16,
                      text: "+2 Nights",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red_02,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Ocean View Apartment",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      bottom: 6,
                    ),
                    CustomText(
                      text: "Nov 02, 2025",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Earned",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffFEE2E2),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: CustomText(
                        text: "Cancelled",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffB91C1C),
                      ),
                    ),
                    CustomText(
                      top: 16,
                      text: "+2 Nights",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red_02,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
