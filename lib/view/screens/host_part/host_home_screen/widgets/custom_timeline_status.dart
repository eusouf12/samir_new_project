import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomTimelineStatus extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const CustomTimelineStatus({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CustomImage(imageSrc: AppIcons.checkIcon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                left: 8,
                text: title?? "Deal Created",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                left: 8,
                text: subtitle?? "Jan 15, 2025",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textClr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
