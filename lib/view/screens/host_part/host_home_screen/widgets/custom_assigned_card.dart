import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomAssignedCard extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final Color? iconColor;
  const CustomAssignedCard({super.key, this.icon,this.iconColor, this.title, this.subtitle});

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
                child: Icon(icon ?? Icons.camera_alt, size: 30, color: iconColor,),
            ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
