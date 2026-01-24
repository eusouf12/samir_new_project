import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../host_part/collaboration_screen/controller/collabration_controller.dart';

class InfActiveHostProfileScreen extends StatelessWidget {
  InfActiveHostProfileScreen({super.key});
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String userId = args['id'];
    final String name = args['name']?? "";
    final String userName = args['userName'] ??"";
    final String image = args['image'] ??"";
    final String followers = args['followers']??"";
    final bool founderMember = args['founderMember']??false;
    final String date = "2026-12-24T21:43:46.978Z";

    WidgetsBinding.instance.addPostFrameCallback((_) {
    //  collaborationController.getSingleUserCollaboration(id: userId);
    });
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Host Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Stack(
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
              ),
              SizedBox(width: 10),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Tasnim Ruhi",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      bottom: 4,
                    ),
                    Container(
                      width: 160,
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
                    CustomText(
                      top: 8,
                      text: "@tasnimruhi",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      right: 20,
                      bottom: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        CustomText(
                          text: "4.9",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          right: 6,
                        ),
                        CustomText(
                          text: "(32 collaborations)",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textClr,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomText(
                top: 20,
                text: "About Host",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                top: 10,
                text:
                    "Airband Super host passionate aboutauthentic travel experiences. I collaborate with content creators to showcase beautiful stays near the coast.",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textClr,
                maxLines: 5,
                textAlign: TextAlign.start,
              ),
              CustomText(
                top: 20,
                text: "Recent Listings",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                bottom: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
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
                    CustomNetworkImage(
                      imageUrl: AppConstants.banner,
                      height: 190.h,
                      width: MediaQuery.sizeOf(context).width,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            top: 10,
                            text: "Cozy Seaside Apartment",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            bottom: 8,
                          ),
                          CustomText(
                            text: "Lisbon, Portugal",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            bottom: 10,
                          ),
                          CustomButtonTwo(
                            onTap: () {},
                            title: "View on Airband",
                            textColor: AppColors.black_02,
                            fillColor: Color(0xffF3F4F6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
