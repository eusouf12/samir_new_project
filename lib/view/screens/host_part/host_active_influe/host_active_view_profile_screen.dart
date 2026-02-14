import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_active_influe/widgets/custom_past_deals_card.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_active_influe/widgets/custom_review_card.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../collaboration_screen/controller/collabration_controller.dart';
import 'controller/influencer_list_host_controller.dart';
import 'model/all_user_model.dart';

class HostActiveViewProfileScreen extends StatelessWidget {
  HostActiveViewProfileScreen({super.key});
  final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String userId = args['id'];
    final String name = args['name']?? "";
    final String userName = args['userName'] ??"";
    final String image = args['image'] ??"";
    final List<dynamic> socialMediaLinks = args['socialMediaLinks'] ?? [];
    final bool founderMember = args['founderMember']??false;
    final int nightCredits = args['nightCredits']??0;
    final String date = "2026-12-24T21:43:46.978Z";


    WidgetsBinding.instance.addPostFrameCallback((_) {
       collaborationController.getSingleUserCollaboration(id: userId,filterName: "completed");
       collaborationController.getUserReviews(userId: userId);
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Influencer Profile",),

      body: Column(
        children: [
          //influencer profile info
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
                      //image
                      Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: ApiUrl.baseUrl + image,
                            height: 95,
                            width: 95,
                            boxShape: BoxShape.circle,
                          ),
                          founderMember?Positioned(
                            bottom: 5,
                            right: 4,
                            child: CustomImage(imageSrc: AppIcons.kingIcon),
                          ): SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          CustomText(
                            text: name,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          //user name founder name
                          CustomText(
                            text: userName,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            right: 20,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              founderMember==true?Container(
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
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              )
                                  : SizedBox.shrink(),
                              SizedBox(width: 8),
                              Container(
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
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  // ====== platform followers ===========
                  Row(
                    children: (socialMediaLinks ).isEmpty
                        ? [
                      SizedBox.shrink()
                    ]
                        : (socialMediaLinks).map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Icon(
                              _getPlatformIcon(item['platform'] ?? ''),
                              size: 20,
                              color: _getPlatformColor(item['platform'] ?? ''),
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              text: "${item['followers'] ?? 0} ",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),

                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  CustomButtonTwo(
                    onTap: (){
                      Get.toNamed(AppRoutes.hostCreateDealScreen,arguments: {"page": "Collaboration", "id": userId},);
                    },
                      height: 40,
                      title: "Send Collaboration Request",
                      fontSize: 12,
                      borderRadius: 10,
                    ),
                ],
              ),
            ),
          ),
          //past deals
          // ================= PAST DEALS =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Obx(() {
              if (collaborationController.singleUserCollaborationStatus.value == Status.loading) {
                 return const Center(child: CustomLoader());
              }
              final completedDeals = collaborationController.singleUserCollaborationList;

              if (completedDeals.isEmpty) {
                return Column(children: const [SizedBox(height: 30), CustomText(text: "No past deals found", fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textClr,),],);
              }

              return Column(
                children: [
                  // Past Deals total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Past Deals",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.hostPastDealsScreen,arguments: userId);
                        },
                        child: CustomText(
                          text: "view All",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: completedDeals.isEmpty ? 0 : (completedDeals.length > 5 ? 5 : completedDeals.length),
                    itemBuilder: (context, index) {
                      final deal = completedDeals[index];
                      return CustomPastDealsCard(
                        imageUrl: (deal.selectDeal?.title?.images?.isNotEmpty ?? false) ? ApiUrl.baseUrl + deal.selectDeal!.title!.images!.first : "",
                        title: deal.selectDeal?.title?.title,
                        hostName: deal.userId?.name,
                        //date: deal.createdAt,
                        // onSendRequest: () {
                        //   Get.toNamed(AppRoutes.hostSendCollaboarationScreen,
                        //     arguments: {
                        //       "id": user.id,
                        //       "name": user.name,
                        //       "image": user.image,
                        //     },
                        //   );
                        // },
                      );
                    },
                  ),
                ],
              );
            }),
          ),
          // ==================== Reviews Section ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Obx(() {
              if (collaborationController.isReviewLoading.value) {
                return const Center(child: CustomLoader());
              }
              final reviews = collaborationController.userReviewsList;

              if (reviews.isEmpty) {
                return Column(
                  children: const [
                    SizedBox(height: 30),
                    CustomText(
                      text: "No reviews found",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Review",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.reviewAllScreen, arguments: userId);
                        },
                        child: CustomText(
                          text: "view All",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Review List (Preview max 5)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: reviews.length > 5 ? 5 : reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return CustomReviewCard(
                        hostName: review.reviewer.name ,
                        comment: review.comment ?? "",
                        imageUrl:ApiUrl.baseUrl + review.reviewer.image,
                        date: review.createdAt,
                        rating: review.rating.toDouble() ?? 5.0,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              );
            }),
          ),
        ],
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
