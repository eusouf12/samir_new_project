import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_assigned_card.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_timeline_status.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';

class HostDealOverviewScreen extends StatelessWidget {
  const HostDealOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Deal Overview"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CustomText(
                  text: "Manage all your collaborations in one place",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textClr,
                  bottom: 16,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Weekend Stay Collaboration –\nVilla Serenity",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                      bottom: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppConstants.girlsPhoto2,
                              height: 36,
                              width: 36,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Michael Chen",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Host",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomImage(imageSrc: AppIcons.arrowBakBak),
                        ),
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppConstants.girlsPhoto2,
                              height: 36,
                              width: 36,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Michael Chen",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Host",
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Listing Information",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      bottom: 8,
                    ),
                    CustomNetworkImage(
                      imageUrl: AppConstants.banner,
                      height: 190.h,
                      width: MediaQuery.sizeOf(context).width,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    CustomText(
                      top: 8,
                      text: "Luxury Beachfront Apartment",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      bottom: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.textClr,
                          size: 18,
                        ),
                        CustomText(
                          left: 6,
                          text: "Manhattan, New York",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textClr,
                        ),
                      ],
                    ),
                    CustomText(
                      top: 8,
                      text:
                          "Stunning ocean front apartment with panoramic views, modern amenities, and prime location steps from the beach.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 6,
                      textAlign: TextAlign.start,
                      bottom: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wifi,
                              color: AppColors.textClr,
                              size: 18,
                            ),
                            CustomText(
                              left: 4,
                              text: "Wi-Fi",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pool,
                              color: AppColors.textClr,
                              size: 18,
                            ),
                            CustomText(
                              left: 4,
                              text: "Pool",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.soup_kitchen,
                              color: AppColors.textClr,
                              size: 18,
                            ),
                            CustomText(
                              left: 4,
                              text: "Kitchen",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.local_parking,
                              color: AppColors.textClr,
                              size: 18,
                            ),
                            CustomText(
                              left: 4,
                              text: "Parking",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textClr,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffF3F4F6),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "View Listing on Airbnb",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              right: 8,
                            ),
                            CustomImage(imageSrc: AppIcons.linkIcon),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Assigned Contents",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomText(
                          text: "2 / 3 Submitted",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomAssignedCard(
                      image: AppIcons.cameraIcon,
                      title:
                          "1 Instagram Reel showcasing the property exterior",
                      subtitle: "Pending",
                    ),
                    CustomAssignedCard(
                      image: AppIcons.videoIcon,
                      title: "1 TikTok video highlighting guest experience",
                      subtitle: "Pending",
                    ),
                    CustomAssignedCard(
                      image: AppIcons.editIcons,
                      title: "Tag @HostProfile and use #HostinfluCollab",
                      subtitle: "Pending",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Timeline & Status",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      bottom: 16,
                    ),
                    CustomTimelineStatus(
                      title: "Deal Created",
                      subtitle: "Jan 15, 2025",
                    ),
                    CustomTimelineStatus(
                      title: "Content Submitted",
                      subtitle: "2 / 3 Submitted",
                    ),
                    CustomTimelineStatus(
                      title: "Payment Released",
                      subtitle: "Pending",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffeff4ff),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Payment Details",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          bottom: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffFFEDD5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            left: 2,
                            text: "🟡 Pending",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffC2410C),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Total Amount",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            text: "\$250",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.info,
                            size: 24,
                            color: AppColors.blue,
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: CustomText(
                            left: 6,
                            text:
                                "Payment released automatically after Host approval of all deliverables.",
                            fontSize: 12,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            color: Color(0xff1E3A8A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              CustomText(
                text: "Enter Your tiktok video link",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                bottom: 10,
              ),
              CustomTextField(
                fillColor: AppColors.white,
                fieldBorderColor: Color(0xffD1D5DB),
                hintText: "@https://www.tiktok.com/discover/",
                hintStyle: TextStyle(color: Color(0xffD1D5DB),),
              ),
              SizedBox(height: 20,),
              CustomButtonTwo(onTap: (){},title: "Release Payment",)
            ],
          ),
        ),
      ),
    );
  }
}
