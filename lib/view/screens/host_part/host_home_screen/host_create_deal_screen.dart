import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class HostCreateDealScreen extends StatelessWidget {
  const HostCreateDealScreen({super.key});

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
                    text: "Step 1 of 4",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 6,
                  ),
                  CustomText(
                    text: "Deal Basics",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    bottom: 6,
                  ),
                  LinearProgressIndicator(
                    value: 0.25,
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
                  CustomFormCard(title: "Title",
                      hintText: "Enter Title",
                      controller: TextEditingController()),
                  CustomFormCard(title: "Select Listing",
                      hintText: "Choose your listing",
                      controller: TextEditingController()),
                  CustomFormCard(title: "Check In",
                      hintText: "mm/dd/yyyy",
                      controller: TextEditingController()),
                  CustomFormCard(title: "Check Out",
                      hintText: "mm/dd/yyyy",
                      controller: TextEditingController()),
                   SizedBox(height: 50,),
                  CustomButtonTwo(onTap: (){
                    Get.toNamed(AppRoutes.hostCreateDealTwoScreen);
                  },title: "Next →",)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
