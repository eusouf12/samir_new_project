import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CampaignCard extends StatelessWidget {
  final String? bannerImage;
  final String? profileImage;
  final String? hostName;
  final bool? isVerified;
  final String? rewardTitle;
  final String? campaignTitle;
  final String? location;

  final VoidCallback? messageButton;
  final VoidCallback? onViewDetails;
  final VoidCallback? onPrimaryAction;

  const CampaignCard({
     super.key,
     this.bannerImage,
     this.profileImage,
     this.hostName,
     this.isVerified = false,
     this.rewardTitle,
     this.campaignTitle,
     this.location,
     this.onViewDetails,
     this.onPrimaryAction,
     this.messageButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.white_50,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Banner
          CustomNetworkImage(
            imageUrl: bannerImage ?? "",
            height: 190.h,
            width: MediaQuery.sizeOf(context).width,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.r),
              topRight: Radius.circular(13.r),
            ),
          ),

          SizedBox(height: 16.h),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile + Name
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: profileImage ?? "",
                      height: 46,
                      width: 46,
                      boxShape: BoxShape.circle,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: hostName ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          bottom: 6,
                        ),

                        // Verified Badge
                        if (isVerified == true)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffDCFCE7),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.green,
                                  size: 14,
                                ),
                                CustomText(
                                  left: 6,
                                  text: "Verified Host",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.green,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                //Night Stay
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: AppColors.primary2,
                      size: 24,
                    ),
                    SizedBox(width: 6),
                    CustomText(
                      text: rewardTitle ?? "",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary2,
                    ),
                  ],
                ),

                SizedBox(height: 10),

                CustomText(
                  text: campaignTitle ??"",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textClr,
                  bottom: 4,
                ),

                CustomText(
                  text: "📍 $location",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textClr,
                  bottom: 12,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: CustomButtonTwo(
                        height: 34.h,
                        onTap: onViewDetails,
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
                SizedBox(height: 10,),
                CustomButtonTwo(
                      height: 34.h,
                      onTap: onPrimaryAction,
                      title: "Apply Now",
                      fillColor: AppColors.primary2,
                      borderRadius: 8,
                      fontSize: 12,
                      isBorder: true,
                      borderColor: AppColors.textClr.withValues(alpha: 0.2),
                      borderWidth: 1,
                      textColor: AppColors.textClr,
                    ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}
