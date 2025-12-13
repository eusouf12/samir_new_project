import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomAssignedCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  const CustomAssignedCard({super.key, this.image, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffF9FAFB),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Color(0xffE5E7EB)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 1,
                child: CustomImage(imageSrc:image?? AppIcons.cameraIcon)),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    left: 10,
                    text:
                    title??"1 Instagram Reel showcasing the property exterior",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    maxLines: 4,
                    textAlign: TextAlign.start,
                  ),
                  CustomText(
                    top: 6,
                    left: 10,
                    text:
                    "Pending",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
