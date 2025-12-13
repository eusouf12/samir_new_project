import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_active_influe/widgets/custom_past_deals_card.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class HostActiveViewProfileScreen extends StatelessWidget {
  const HostActiveViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Influencer Profile",
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.girlsPhoto,
                            height: 100,
                            width: 100,
                            boxShape: BoxShape.circle,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 4,
                            child: CustomImage(imageSrc: AppIcons.kingIcon),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Tasnim Ruhi",
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "@tasnimruhi",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                right: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFACC15),
                                      Color(0xffEAB308),
                                      Color(0xffCA8A04),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    CustomImage(imageSrc: AppIcons.king),
                                    CustomText(
                                      left: 6,
                                      text: "Founder Member",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: "125K",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffFD8270),
                                  ),
                                  CustomText(
                                    text: "Followers",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textClr,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  CustomText(
                                    text: "8.5%",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff16A34A),
                                  ),
                                  CustomText(
                                    text: "Followers",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textClr,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffff2f1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: CustomText(
                                  text: "Influencer",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFD8270),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Past Deals",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "12 completed",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomPastDealsCard(),
                CustomPastDealsCard(),
                CustomPastDealsCard(),
                SizedBox(height: 20,),
                CustomText(
                  textAlign: TextAlign.start,
                  text: "Performance Analytics",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  bottom: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye,color: AppColors.blue,size: 18,),
                                CustomText(
                                  left: 6,
                                  text: "Views",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            CustomText(
                              top: 4,
                              text: "47.2K",
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              bottom: 4,
                            ),
                            CustomText(
                              text: "Manual entry",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.ads_click,color: AppColors.green,size: 18,),
                                CustomText(
                                  left: 6,
                                  text: "Clicks",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            CustomText(
                              top: 4,
                              text: "3.8K",
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              bottom: 4,
                            ),
                            CustomText(
                              text: "Auto-tracked",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Row(
                         children: [
                           CustomImage(imageSrc: AppIcons.grapicon),
                           CustomText(
                             left: 6,
                             text: "Click-Through Rate",
                             fontSize: 14,
                             fontWeight: FontWeight.w500,
                             color: AppColors.textClr,
                           ),
                         ],
                       ),
                        CustomText(
                          text: "8.05%",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    LinearProgressIndicator(
                      value: 0.8,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primary,
                      backgroundColor: AppColors.greyLight,
                    ),
                    CustomText(
                      top: 6,
                      text: "Formula: (Clicks ÷ Views) × 100",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                ),
              ),
            )],
            ),
          ),
        ],
      ),
    );
  }
}
