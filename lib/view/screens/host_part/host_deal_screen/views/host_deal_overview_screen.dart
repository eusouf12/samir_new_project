import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/core/app_routes/app_routes.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_assigned_card.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/widgets/custom_timeline_status.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_listing_screen/controller/listing_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../host_listing_screen/widgets/listin_custom_card.dart';
import '../controller/deals_controller.dart';

class HostDealOverviewScreen extends StatelessWidget {
  HostDealOverviewScreen({super.key});
  final DealsController dealsController = Get.put(DealsController());
  final ListingController listingController = Get.put(ListingController());
  final Map<String, dynamic> args =
  Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final dealId = args['dealId'];
    final titleId = args['titleId'];
    final status = args['status'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dealsController.singleGetDeal(id: dealId);
      listingController.singleGetListing(id: titleId);
    });

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Deal Overview",centerTitleEnable: false,),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Obx((){
              if (dealsController.rxSingleDealStatus.value == Status.loading) {
                return  Center(child: CustomLoader());
              }
              if (dealsController.rxSingleDealStatus.value == Status.error) {
                return const Center(child: Text("Something went wrong"));
              }
              if (dealsController.singleDealList.isEmpty) {
                return const Center(child: Text("No deals available"));
              }
              final deal = dealsController.singleDealList.first;
              final int totalDeliverables = deal.deliverables.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Listing Information",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    bottom: 8,
                  ),
                  //listing card
                  Obx((){
                    if (listingController.singleListingList.isEmpty) {return const SizedBox();}

                    final listing = listingController.singleListingList.first;

                   return ListingCard(
                      listing: listing,
                      btn: false,
                      btn2: false,
                      onTapAirbnb: () async {
                        final link = listing.addAirbnbLink;
                        if (link.isEmpty) return;

                        final uri = Uri.parse(
                          link.startsWith('http') ? link : 'https://$link',
                        );

                        await launchUrl(uri, mode: LaunchMode.externalApplication,);
                      },
                    );

                  }),
                  SizedBox(height: 20),
                  // payment and night count
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
                              text: "Night Stay : ",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              bottom: 16,
                            ),
                            CustomText(
                              text: "${deal.compensation.numberOfNights} ${deal.compensation.numberOfNights > 1 ? "Days" : "Day"}",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              bottom: 16,
                            ),

                          ],
                        ),
                        SizedBox(height: 5),
                        // //Direct Payment
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     CustomText(
                        //       text: "Direct Payment : ",
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w500,
                        //       bottom: 16,
                        //     ),
                        //     CustomText(
                        //       text: "${deal.compensation.directPayment == true?"Yes":"No"}",
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w500,
                        //       bottom: 16,
                        //     ),
                        //
                        //   ],
                        // ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Total Payment : ",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              bottom: 16,
                            ),
                            CustomText(
                              text: "\$${deal.compensation.paymentAmount}",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              bottom: 16,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height:20),
               // ===== Minimum Followers Required =====
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Minimum Followers Required",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          bottom: 12,
                        ),


                        ..._uniquePlatformFollowers(deal.deliverables)
                            .entries
                            .map((entry) {
                          final platform = entry.key;
                          final followers = entry.value;


                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  dealsController.platformIcons[platform],
                                  size: 18,
                                  color: dealsController.platformColors[platform],
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: "$platform • $followers followers",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //assign content
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
                              text: "${totalDeliverables}",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blue,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: deal.deliverables.map((deliverable) {
                            String titleText = "${deliverable.quantity} ${deliverable.platform} ${deliverable.contentType} showcasing the property";
                            IconData icon;
                            Color iconColor;

                            switch (deliverable.platform.toLowerCase()) {
                              case "instagram":
                                icon = Icons.camera_alt;
                                iconColor = Color(0xFFE1306C);
                                break;
                              case "tiktok":
                                icon = Icons.video_collection;
                                iconColor = Color(0xFF69C9D0);
                                break;
                              case "facebook":
                                icon = Icons.facebook;
                                iconColor = Color(0xFF1877F2);
                                break;
                              case "youtube":
                                icon = Icons.video_library;
                                iconColor = Color(0xFFFF0000);
                                break;
                              default:
                                icon = Icons.edit;
                                iconColor = Colors.grey;
                            }

                            return CustomAssignedCard(
                              icon: icon,
                              iconColor: iconColor,
                              title: titleText,
                            );
                          }).toList(),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomButton(
                          onTap: (){
                            Get.toNamed(AppRoutes.hostUpdateDealScreen,arguments: dealId);
                          },
                          height: 34.h,
                          title: "Edit",
                          fillColor: AppColors.primary,
                          borderRadius: 8,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Flexible(
                        flex: 1,
                        child: CustomButtonTwo(
                          onTap: (){
                            dealsController.deleteDeal(id: dealId);
                          },
                          height: 34.h,
                          title: "Delete",
                          borderRadius: 8,
                          fontSize: 12,
                          fillColor: AppColors.white,
                          isBorder: true,
                          borderColor: AppColors.primary.withValues(alpha: 0.5),
                          borderWidth: 1,
                          textColor: AppColors.textClr,
                        ),
                      ),
                    ],
                  )

                ],
              );

            })
          ),
        ),
      ),
    );
  }
  Map<String, String> _uniquePlatformFollowers(List deliverables) {
    final Map<String, String> result = {};


    for (final d in deliverables) {
      final Map<String, dynamic>? followers =
      d.platformFollowers as Map<String, dynamic>?;


      if (followers == null) continue;


      for (final entry in followers.entries) {
// যদি platform আগে থেকেই থাকে → skip
        if (!result.containsKey(entry.key)) {
          result[entry.key] = entry.value.toString();
        }
      }
    }


    return result;
  }
}
