import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_active_influe/widgets/custom_past_deals_card.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import 'controller/influencer_list_host_controller.dart';

class HostActiveViewProfileScreen extends StatelessWidget {
  HostActiveViewProfileScreen({super.key});
  final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());
  final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String userId = args['id'];
    final String name = args['name']?? "";
    final String userName = args['userName'] ??"";
    final String image = args['image'] ??"";
    final String followers = args['followers']??"";
    final bool founderMember = args['founderMember']??false;
    final String date = "2026-12-24T21:43:46.978Z";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // influencerListHostController.getMyCollaborations();
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
                            height: 100,
                            width: 100,
                            boxShape: BoxShape.circle,
                          ),
                          founderMember?Positioned(
                            bottom: 5,
                            right: 4,
                            child: CustomImage(imageSrc: AppIcons.kingIcon),
                          ): SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  //followers
                                  Column(
                                    children: [
                                      CustomText(
                                        text: followers,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFD8270),
                                      ),
                                      CustomText(
                                        text: "Followers",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textClr,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 15),
                          //founder member
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                        ],
                      )
                    ],
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
              // loader
              // if (influencerListHostController.rxCollaborationStatus.value == Status.loading) {
              //    return const Center(child: CustomLoader());
              // }

             // final completedDeals = influencerListHostController.collaborationList.where((e) => e.status == 'completed').toList();

              // if (completedDeals.isEmpty) {
              //   return Column(
              //     children: const [
              //       SizedBox(height: 30),
              //       CustomText(text: "No past deals found", fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textClr,),
              //     ],
              //   );
              // }

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
                      // CustomText(
                      //   text: "${completedDeals.length} completed",
                      //   fontSize: 14,
                      //   fontWeight: FontWeight.w400,
                      //   color: AppColors.textClr,
                      // ),
                    ],
                  ),

                  /// list
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   itemCount: completedDeals.length,
                  //   itemBuilder: (context, index) {final deal = completedDeals[index];
                  //
                  //     return CustomPastDealsCard(
                  //       imageUrl: AppConstants.allSportsImage,
                  //       title: deal.selectDeal.description,
                  //       hostName: deal.userId.name,
                  //       date: deal.createdAt,
                  //     );
                  //   },
                  // ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
