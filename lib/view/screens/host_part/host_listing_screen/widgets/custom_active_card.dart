import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomActiveCard extends StatelessWidget {
  const CustomActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.girlsPhoto,
                    height: 64,
                    width: 64,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Sarah Anderson",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "@sarahtravels",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: List.generate(3, (value) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffECFEFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        text: "Travel",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Flexible(
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: () {
                        Get.toNamed(AppRoutes.hostActiveViewProfileScreen);
                      },
                      title: "View Profile",
                      fontSize: 12,
                      borderRadius: 10,
                      isBorder: true,
                      fillColor: AppColors.white,
                      textColor: AppColors.black_02,
                      borderWidth: 1,
                      borderColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Flexible(
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: () {
                        Get.toNamed(AppRoutes.hostSendCollaboarationScreen);
                      },
                      title: "Send Request",
                      fontSize: 12,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
