import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_active_influe/widgets/custom_past_deals_card.dart';

import '../../../../../service/api_url.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../collaboration_screen/controller/collabration_controller.dart';


class HostPastDealsScreen extends StatelessWidget {
  HostPastDealsScreen({super.key});
  final CollaborationController collaborationController = Get.put(CollaborationController());
  final userId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      collaborationController.getSingleUserCollaboration(id: userId,filterName: "completed");
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Completed Deals",),

      body: Column(
        children: [

          //past deals
          // ================= PAST DEALS =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Obx(() {
              // loader
              if (collaborationController.singleUserCollaborationStatus.value == Status.loading) {
                return const Center(child: CustomLoader());
              }

              final completedDeals = collaborationController.singleUserCollaborationList;

              if (completedDeals.isEmpty) {
                return Column(children: const [SizedBox(height: 30), CustomText(text: "No past deals found", fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textClr,),],);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: completedDeals.isEmpty ? 0 : (completedDeals.length > 5 ? 5 : completedDeals.length),
                itemBuilder: (context, index) {
                  final deal = completedDeals[index];
                  return CustomPastDealsCard(
                    imageUrl: (deal.title?.images?.isNotEmpty ?? false) ? ApiUrl.baseUrl + deal.title!.images!.first : "",
                    title: deal.title?.title,
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
