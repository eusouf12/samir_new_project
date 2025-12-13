import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomInfHomeCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final Function()? onTap;
  const CustomInfHomeCard({super.key, this.image, this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width /2.3,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImage(imageSrc:image?? AppIcons.starIcon),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title?? "14", fontSize: 24, fontWeight: FontWeight.w700),
                CustomText(text: subtitle?? "Night Credits", fontSize: 14, fontWeight: FontWeight.w500),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
