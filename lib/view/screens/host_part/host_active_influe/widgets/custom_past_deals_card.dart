import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomPastDealsCard extends StatelessWidget {
  const CustomPastDealsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.allSportsImage,
                height: 64,
                width: 64,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Downtown Loft",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "by Michael Chen",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffDCFCE7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CustomText(
                          text: "Completed",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff15803D),
                        ),
                      ),
                      CustomText(
                        left: 20,
                        text: "Dec 15, 2023",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                color: AppColors.primary,
                focusColor: AppColors.primary,
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
