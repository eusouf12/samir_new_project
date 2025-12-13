import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomActivityCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? time;
  final String? number;
  final Function()? onTap;
  const CustomActivityCard({super.key, this.icon, this.title, this.time, this.number, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 1,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImage(imageSrc: icon?? AppIcons.collaboraIcon),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: title?? " ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: time??" ",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textClr,
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 12,
                  child: CustomText(text: number?? " ",color: AppColors.white,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
