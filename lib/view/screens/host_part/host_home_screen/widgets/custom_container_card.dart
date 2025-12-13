import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomContainerCard extends StatelessWidget {
  final String? title;
  final String? number;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;
const CustomContainerCard({super.key, this.title, this.number, this.onTap, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96.w,
        width: 100.w,
        decoration: BoxDecoration(
          color: color?? AppColors.primary,
          border: Border.all(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: title ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color:textColor ?? AppColors.white,
            ),CustomText(
              top: 4,
              text: number?? "",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textColor?? AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
