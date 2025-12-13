import 'package:flutter/material.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_text/custom_text.dart';
class HostCollaborationViewDetailsScreen extends StatelessWidget {
  const HostCollaborationViewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Request Details",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                CustomNetworkImage(imageUrl: AppConstants.girlsPhoto,height: 64,width: 64,boxShape: BoxShape.circle,),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Sarah Anderson",fontSize: 14,fontWeight: FontWeight.w600,),
                    CustomText(text: "@sarahtravels",fontSize: 12,fontWeight: FontWeight.w400,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
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
                    text: "Collaboration Overview",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    bottom: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Listing",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: "Beach front Apartment",
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
                        text: "Duration",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: "Nov 10 – Nov 15, 2025",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomText(
                    text: "Deliverables",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    bottom: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.check,size: 24,color: AppColors.green,),
                      CustomText(
                        text: "1 Instagram Reel",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.check,size: 24,color: AppColors.green,),
                      CustomText(
                        text: "1 TikTok Video",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.check,size: 24,color: AppColors.green,),
                      CustomText(
                        text: "3 Story Posts",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
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
                    text: "Offers",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    bottom: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Total Value",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: "\$250",
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Payment Method",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: "Stripe",
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
                        text: "Host Credit Reward",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: "3 Night Credits",
                        fontSize: 16,
                        color: Color(0xffF59E0B),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20,left: 20.0),
        child: Row(
          children: [
            Flexible(child: CustomButtonTwo(onTap: (){},title: "Decline",fillColor: AppColors.red_02,)),
            SizedBox(width: 16,),
            Flexible(child: CustomButtonTwo(onTap: (){},title: "Accept",fillColor: AppColors.primary,))
          ],
        ),
      ),
    );
  }
}
