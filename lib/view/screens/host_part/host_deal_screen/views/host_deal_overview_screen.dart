import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                return const Center(child: CustomLoader());
              }
              if (dealsController.rxSingleDealStatus.value == Status.error) {
                return const Center(child: Text("Something went wrong"));
              }
              if (dealsController.singleDealList.isEmpty) {
                return const Center(child: Text("No deals available"));
              }

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
                    final listing = listingController.singleListingList.first;

                   return ListingCard(
                      listing: listing,
                      onTapAirbnb: () async {
                        final link = listing.addAirbnbLink;
                        if (link.isEmpty) return;

                        final uri = Uri.parse(
                          link.startsWith('http') ? link : 'https://$link',
                        );

                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    );

                  }),
                  SizedBox(height: 20),
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
                              text: "2 / 3 Submitted",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blue,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomAssignedCard(
                          image: AppIcons.cameraIcon,
                          title:
                          "1 Instagram Reel showcasing the property exterior",
                          subtitle: "Pending",
                        ),
                        CustomAssignedCard(
                          image: AppIcons.videoIcon,
                          title: "1 TikTok video highlighting guest experience",
                          subtitle: "Pending",
                        ),
                        CustomAssignedCard(
                          image: AppIcons.editIcons,
                          title: "Tag @HostProfile and use #HostinfluCollab",
                          subtitle: "Pending",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Timeline & Status",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          bottom: 16,
                        ),
                        CustomTimelineStatus(
                          title: "Deal Created",
                          subtitle: "Jan 15, 2025",
                        ),
                        CustomTimelineStatus(
                          title: "Content Submitted",
                          subtitle: "2 / 3 Submitted",
                        ),
                        CustomTimelineStatus(
                          title: "Payment Released",
                          subtitle: "Pending",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                              text: "Payment Details",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              bottom: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xffFFEDD5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                left: 2,
                                text: "🟡 Pending",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffC2410C),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Total Amount",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomText(
                                text: "\$250",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Icon(
                                Icons.info,
                                size: 24,
                                color: AppColors.blue,
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: CustomText(
                                left: 6,
                                text:
                                "Payment released automatically after Host approval of all deliverables.",
                                fontSize: 12,
                                maxLines: 2,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                                color: Color(0xff1E3A8A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomButtonTwo(onTap: (){},title: "Release Payment",)
                ],
              );

            })
          ),
        ),
      ),
    );
  }
}
