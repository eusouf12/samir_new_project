import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomCollaborationCard extends StatelessWidget {
  final String? profileImage;
  final String? userName;
  final String? userHandle;
  final List<String>? tags;
  final String? location;
  final VoidCallback? onViewDetailsTap;
  final VoidCallback? onApproveTap;
  final VoidCallback? onDeclineTap;

  const CustomCollaborationCard({
    super.key,
    this.profileImage,
    this.userName,
    this.userHandle,
    this.tags,
    this.location,
    this.onViewDetailsTap,
    this.onApproveTap,
    this.onDeclineTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
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
            // ===== User Info =====
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: profileImage ?? "https://via.placeholder.com/64",
                  height: 64,
                  width: 64,
                  boxShape: BoxShape.circle,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: userName ?? "Unknown",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: userHandle ?? "@unknown",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ===== Tags =====
            if (tags != null && tags!.isNotEmpty)
              Row(
                children: tags!.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFEFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        text: tag,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 10),

            // ===== Location =====
            if (location != null)
              Row(
                children: [
                  const Icon(Icons.home, size: 24, color: AppColors.textClr),
                  CustomText(
                    text: location ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButtonTwo(
                    height: 40,
                    onTap: onViewDetailsTap,
                    title: "View Details",
                    fontSize: 12,
                    borderRadius: 10,
                    isBorder: true,
                    fillColor: AppColors.white,
                    textColor: AppColors.black_02,
                    borderWidth: 1,
                    borderColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  flex: 2,
                  child: CustomButtonTwo(
                    height: 40,
                    onTap: onApproveTap,
                    title: "Approve",
                    fontSize: 12,
                    borderRadius: 10,
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                    height: 40,
                    fillColor: AppColors.red_02,
                    onTap: onDeclineTap,
                    title: "X",
                    textColor: AppColors.white,
                    fontSize: 12,
                    borderRadius: 10,
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
