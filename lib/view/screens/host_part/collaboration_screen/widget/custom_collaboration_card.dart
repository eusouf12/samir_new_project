import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/collaboration_single_model.dart';

class CustomCollaborationCard extends StatelessWidget {
  final String? profileImage;
  final String? role;
  final String? userName;
  final bool? isMe;
  final String? userHandle;
  final String? status;
  final List<String>? tags;
  final String? location;
  final VoidCallback? onViewDetailsTap;
  final VoidCallback? onPaymentTap;
  final VoidCallback? onApproveTap;
  final VoidCallback? onDeclineTap;
  final List<InfluencerSocialMedia> socialMediaLinks;

  const CustomCollaborationCard({
    super.key,
    this.profileImage,
    this.userName,
    this.role,
    this.isMe,
    this.status,
    this.userHandle,
    this.tags,
    this.location,
    this.onViewDetailsTap,
    this.onPaymentTap,
    this.onApproveTap,
    this.onDeclineTap,
    required this.socialMediaLinks,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: profileImage ?? "",
                          height: 64,
                          width: 64,
                          boxShape: BoxShape.circle,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: userName ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              CustomText(
                                text: "@${userHandle}" ?? "",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                bottom: 10,
                              ),
                              role == "host"
                              ?Row(
                                children: socialMediaLinks.isEmpty
                                    ? []
                                    : socialMediaLinks.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getPlatformIcon(item.platform ?? ""),
                                          size: 18,
                                          color: _getPlatformColor(item.platform ?? ""),
                                        ),
                                        const SizedBox(width: 4),
                                        CustomText(
                                          text: item.followers ?? "0",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                              :SizedBox.shrink(),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: status== "accepted" ? Color(0xFFE8F5E9) : status == "rejected" ? Colors.red.withOpacity(0.1) :status== "ongoing" ? AppColors.primary.withOpacity(0.1) :Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color:status== "accepted"? Colors.green : status== "rejected" ? Colors.red : status== "ongoing" ? AppColors.primary  : Colors.orange, width: 1),
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(text: status == "accepted" ? "Accepted" : status == "rejected" ? "Rejected" : status== "ongoing" ? "Ongoing"  : "Pending",
                          color: status == "accepted" ? Colors.green : status == "rejected" ? Colors.red : status== "ongoing" ? AppColors.primary  : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ],
                    ),
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
                      borderColor: role == "host" ? AppColors.primary : AppColors.primary2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  //payment
                  (isMe == false)?
                  ( status == "accepted" && role =="host")?
                       Expanded(
                    flex: 2,
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: onPaymentTap,
                      title: "Make Payment",
                      fontSize: 12,
                      borderRadius: 10,
                      isBorder: true,
                      fillColor: role == "host" ? AppColors.primary : AppColors.primary2,
                      textColor: AppColors.white,
                      borderWidth: 1,
                      borderColor: role == "host" ? AppColors.primary : AppColors.primary2,
                    ),
                  )
                      : SizedBox.shrink()
                  :SizedBox.shrink(),
                  const SizedBox(width: 8),
                  //approve
                  (isMe == false)?
                  (status == "ongoing" || status == "rejected" || status == "accepted")?
                  SizedBox.shrink()
                      : Expanded(
                    flex: 2,
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: onApproveTap,
                      title: "Approve",
                      fontSize: 12,
                      borderRadius: 10,
                      fillColor: role == "host" ? AppColors.primary : AppColors.primary2,
                    ),
                  )
                  :SizedBox.shrink(),
                  const SizedBox(width: 8),
                  //rejected
                  (status == "ongoing" || status == "rejected" || status == "accepted")?
                    SizedBox.shrink()
                      : Expanded(
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
      ),
    );
  }
  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt;
      case 'facebook':
        return Icons.facebook;
      case 'tiktok':
        return Icons.music_note;
      case 'youtube':
        return Icons.play_circle_fill;
      case 'x':
      case 'twitter':
        return Icons.alternate_email;
      default:
        return Icons.public;
    }
  }
  Color _getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return const Color(0xFFE1306C); // pink
      case 'facebook':
        return const Color(0xFF1877F2); // blue
      case 'tiktok':
        return Colors.black;
      case 'youtube':
        return const Color(0xFFFF0000); // red
      case 'x':
      case 'twitter':
        return Colors.black;
      default:
        return AppColors.primary;
    }
  }
}
