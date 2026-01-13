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
  final String? status;
  final void Function()? viewDetailsButton;
  final void Function()? messageButton;
  const CustomDealsContainer({super.key, this.profileImg,this.status, this.fullName, this.userName, this.userImg, this.deliverablesText, this.paymentText, this.progressText, this.durationText, this.viewDetailsButton, this.messageButton});

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
              children: [
                CustomNetworkImage(
                  imageUrl: profileImg ?? "",
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(width: 10),
                // left content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: fullName ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        bottom: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: userImg ?? AppConstants.girlsPhoto,
                            height: 25,
                            width: 25,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          CustomText(
                            left: 6,
                            text: userName ?? "",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textClr,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // RIGHT STATUS COLUMN
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //     color: status == "pending" ? Color(0xffFFEDD5) : Color(0xffDCFCE7),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.circle, size: 10, color: status == "pending" ? AppColors.red : AppColors.green,),
                    //       CustomText(
                    //         left: 2,
                    //         text: status == "pending" ? "Pending" : "Active",
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w600,
                    //         color: status == "pending" ? AppColors.red : AppColors.green,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        left: 2,
                        text: "Host",
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
                  //Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Duration",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      CustomText(
                        text: durationText ??"",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  //Payment
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Payment",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Deliverables",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomText(
                          text: deliverablesText?? "",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          maxLines: 10,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.end,
                        ),
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


String getPlatformShort(String platform) {
  switch (platform.toLowerCase()) {
    case 'instagram':
      return 'IG';
    case 'tiktok':
      return 'TT';
    case 'facebook':
      return 'FB';
    case 'youtube':
      return 'YT';
    default:
      return '';
  }
}

String buildDeliverablesText(List deliverables) {
  final List<String> items = [];

  for (var d in deliverables) {
    final short = getPlatformShort(d['platform'] ?? '');
    if (short.isEmpty) continue;

    items.add('${d['quantity']} $short ${d['contentType']}');
  }

  return items.join(', ');
}
