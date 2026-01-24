import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomHostActiveCard extends StatelessWidget {
  final String? name;
  final String? username;
  final String? location;
  final String? imageUrl;
  final VoidCallback? onViewProfile;
  final VoidCallback? onSendMessage;

  const CustomHostActiveCard({
     super.key,
     this.name,
     this.location,
     this.username,
     this.imageUrl,
     this.onViewProfile,
     this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              /// ===== Profile Row =====
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: imageUrl ?? "",
                    height: 64,
                    width: 64,
                    boxShape: BoxShape.circle,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "@$username",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        text: location ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary2,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ===== Buttons =====
              Row(
                children: [
                  Flexible(
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: onViewProfile,
                      title: "View Profile",
                      fontSize: 12,
                      borderRadius: 10,
                      isBorder: true,
                      fillColor: AppColors.white,
                      textColor: AppColors.black_02,
                      borderWidth: 1,
                      borderColor: AppColors.primary2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: onSendMessage,
                      title: "Send Message",
                      fontSize: 12,
                      borderRadius: 10,
                      fillColor: AppColors.primary2,
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
