import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';

import '../../../components/custom_nav_bar/vendor_navbar.dart';
class InfExploreDealsScreen extends StatelessWidget {
  const InfExploreDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Explore Deals"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomTextField(
              isDens: true,
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.primary2,
              hintText: "Search your location",
              hintStyle: TextStyle(color: AppColors.textClr),
              prefixIcon: Icon(Icons.search,size: 24,color: AppColors.textClr,),

            ),
            SizedBox(height: 20,),
            Container(
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.banner,
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
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppConstants.girlsPhoto,
                              height: 46,
                              width: 46,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                CustomText(
                                  text: "Mike Rodriguez",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  bottom: 6,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDCFCE7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.r),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.green,
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
                        Row(
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              color: AppColors.primary2,
                              size: 24,
                            ),
                            CustomText(
                              text: "2 Night Credits",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary2,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          text: "TikTok Video • Mountain Cottage",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textClr,
                          bottom: 4,
                        ),
                        CustomText(
                          text: "📍 Aspen, Colorado",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textClr,
                          bottom: 12,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CustomButtonTwo(
                                onTap: () {},
                                title: "View Details",
                                textColor: AppColors.black_02,
                                fillColor: Color(0xffF3F4F6),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: CustomButtonTwo(
                                onTap: () {},
                                title: "View Details",
                                fillColor: AppColors.primary2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InfNavbar(currentIndex: 1),
    );
  }
}
