import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../collaboration_screen/controller/collabration_controller.dart';
import '../widgets/custom_review_card.dart';


class ReviewAllScreen extends StatelessWidget {
  ReviewAllScreen({super.key});
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final args = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final String userId = args["userId"] ?? "";
    final String role = args["role"] ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      collaborationController.getUserReviews(userId: userId);
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Reviews",),

      body: Column(
        children: [

          // ==================== Reviews Section ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Obx(() {
              if (collaborationController.isReviewLoading.value) {
                return  Center(child: CustomLoader(color: role=="host" ? AppColors.primary : AppColors.primary2));
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

              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return CustomReviewCard(
                        hostName: review.reviewer.name ,
                        comment: review.comment ,
                        imageUrl : ApiUrl.baseUrl + review.reviewer.image,
                        date: review.createdAt,
                        rating: review.rating.toDouble() ,
                      );
                    },
                  );

            }),
          ),
        ],
      ),
    );
  }
}
