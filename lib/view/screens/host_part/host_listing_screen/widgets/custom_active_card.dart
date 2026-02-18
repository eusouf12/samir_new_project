import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button_two.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../host_active_influe/model/all_user_model.dart';

class CustomActiveCard extends StatelessWidget {
  final String name;
  final String? role;
  final int? nightCredits;
  final String username;
  final String imageUrl;
  final List<String> tags;
  final List<SocialMediaLink>? socialMediaLinks;
  final VoidCallback onViewProfile;
  final VoidCallback onViewMessage;
  final VoidCallback? onSendRequest;

  const CustomActiveCard({
    super.key,
    required this.socialMediaLinks,
    required this.name,
    this.nightCredits,
    required this.username,
    required this.imageUrl,
    this.tags = const [],
    required this.onViewProfile,
    required this.onViewMessage,
    this.onSendRequest,
    this.role,
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
              // ===== Profile Row =====
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: imageUrl,
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
                          text: name,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                        CustomText(
                          text: "@$username",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                   SizedBox(width: 8),
                  role == "host"
                      ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Icon(Icons.star, color: Colors.orange, size: 16,),
                         SizedBox(width: 4),

                        Text(
                         "${nightCredits} Night Credits",
                         style: TextStyle(
                           color: Color(0xFF1A237E),
                           fontSize: 11,
                           fontWeight: FontWeight.bold,
                         ),
                                                    ),
                      ],
                    ),
                  )
                      : SizedBox.shrink(),
                ],
              ),

              /// ===== Tags =====
              // if (tags.isNotEmpty) ...[
              //   const SizedBox(height: 16),
              //   Wrap(
              //     spacing: 8,
              //     runSpacing: 8,
              //     children: tags.map((tag) {
              //       return Container(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 12,
              //           vertical: 4,
              //         ),
              //         decoration: BoxDecoration(
              //           color: const Color(0xffECFEFF),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: CustomText(
              //           text: tag,
              //           fontSize: 12,
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.primary,
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ],

              const SizedBox(height: 12),
              // ====== platform followers ===========
              role == "host"
              ?Row(
                children: (socialMediaLinks ?? []).isEmpty
                    ? [
                  SizedBox.shrink()
                ]
                    : (socialMediaLinks!).map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        Icon(
                          _getPlatformIcon(item.platform),
                          size: 18,
                          color: _getPlatformColor(item.platform),
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          text: "${item.followers}",
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
                      borderColor:role == "host" ? AppColors.primary : AppColors.primary2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: CustomButtonTwo(
                      height: 40,
                      onTap: onViewMessage,
                      title: "Send Message",
                      fontSize: 12,
                      borderRadius: 10,
                      fillColor: role == "host" ? AppColors.primary : AppColors.primary2,
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
