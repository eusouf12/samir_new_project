import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomDealsContainer extends StatelessWidget {
  final String? profileImg;
  final String? fullName;
  final String? userName;
  final String? userImg;
  final String? deliverablesText;
  final String? paymentText;
  final String? progressText;
  final String? durationText;
  final void Function()? viewDetailsButton;
  final void Function()? messageButton;
  const CustomDealsContainer({super.key, this.profileImg, this.fullName, this.userName, this.userImg, this.deliverablesText, this.paymentText, this.progressText, this.durationText, this.viewDetailsButton, this.messageButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: profileImg?? AppConstants.girlsPhoto,
                      height: 50,
                      width: 50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: fullName?? "",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          bottom: 2,
                        ),
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:userImg?? AppConstants.girlsPhoto,
                              height: 20,
                              width: 20,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            CustomText(
                              left: 6,
                              text: userName?? "",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffDCFCE7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.green,
                            size: 10,
                          ),
                          CustomText(
                            left: 2,
                            text: "Active",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        left: 2,
                        text: "Influencer",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1D4ED8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffF9FAFB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Deliverables",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: durationText?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Deliverables",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: paymentText?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Deliverables",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: progressText?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Deliverables",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: durationText ??"",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: CustomButtonTwo(
                    height: 34.h,
                    onTap: viewDetailsButton,
                    title: "View Details",
                    borderRadius: 8,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 12,),
                Flexible(
                  flex: 1,
                  child: CustomButtonTwo(
                    height: 34.h,
                    onTap: messageButton,
                    title: "Message",
                    borderRadius: 8,
                    fontSize: 12,
                    fillColor: AppColors.white,
                    isBorder: true,
                    borderColor: AppColors.textClr.withValues(alpha: 0.2),
                    borderWidth: 1,
                    textColor: AppColors.textClr,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
