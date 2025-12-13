import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomProfileCard extends StatelessWidget {
  final String? nameTitle;
  final String? icons;
  final Function()? onTap;
  final Color? color;
  const CustomProfileCard({super.key, this.nameTitle, this.onTap, this.icons, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImage(imageSrc: icons?? AppIcons.editIcon),
                    CustomText(
                      left: 12,
                      text: nameTitle ?? "",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 45,
                  decoration: BoxDecoration(
                    color: color?? AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
