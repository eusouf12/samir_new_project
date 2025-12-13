import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomMessageCard extends StatelessWidget {
  const CustomMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.textClr.withValues(alpha: .1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.girlsPhoto,
                        height: 40,
                        width: 40,
                        boxShape: BoxShape.circle,
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Icon(
                          Icons.circle_rounded,
                          color: AppColors.green,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Tasnim Ruhi",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "Hello, are you here?",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: "12:30",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                    bottom: 8,
                  ),
                  CustomImage(imageSrc: AppIcons.signecherIcon),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
