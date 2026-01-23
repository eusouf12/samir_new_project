import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/collaboration_single_model.dart';

class HostCollaborationViewDetailsScreen extends StatelessWidget {
  HostCollaborationViewDetailsScreen({super.key});
  final args = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final String image = args["image"] ?? "";
    final String name = args["name"] ?? "";
    final String userName = args["userName"] ?? "";
    final String listingName = args["listingName"] ?? "";
    final String listingImage = args["listingImage"] ?? "";
    final String payment = args["payment"] ?? "";
    final int nightStay = args["nightStay"] ?? 0;
    final String inTimeAndDate = args["inTimeAndDate"] ?? "";
    final String outTimeAndDate = args["outTimeAndDate"] ?? "";
    final Map<String, dynamic> amenities = Map<String, dynamic>.from(args["amenities"] ?? {});
    final List<String> amenityList = amenities.entries.where((e) => e.value == true).map((e) => e.key).toList();
    final List deliverables = args["deliverables"] ?? [];

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Request Details",),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomNetworkImage(imageUrl: image ,height: 64,width: 64,boxShape: BoxShape.circle,),
                    SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: name, fontSize: 14,fontWeight: FontWeight.w600,),
                        CustomText(text: userName,fontSize: 12,fontWeight: FontWeight.w400,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                //Collaboration Overview
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  //Collaboration Overview
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Collaboration Overview",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        bottom: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Listing",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textClr,
                          ),
                          CustomText(
                            text: listingName,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      //Duration
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Start Time",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textClr,
                          ),
                          CustomText(
                            text: inTimeAndDate,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "End Time ",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textClr,
                          ),
                          CustomText(
                            text: outTimeAndDate,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      // Deliverables
                      CustomText(
                        text: "Deliverables",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        bottom: 10,
                      ),
                     ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: deliverables.length,
                    itemBuilder: (context, index) {
                      final SingleUserDeliverable item = deliverables[index];

                      return Text(
                        "${item.platform} - ${item.contentType} (${item.quantity})",
                      );
                    },
                  ),
                     SizedBox(height: 10,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // Amenities
                Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Amenities",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          bottom: 12,
                        ),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: amenityList.map((amenity) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomText(
                                text: amenity.replaceAllMapped(RegExp(r'[A-Z]'), (m) => ' ${m.group(0)}',).capitalizeFirst!,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20,),
                //Offers
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Offers",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        bottom: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Total Value",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textClr,
                          ),
                          CustomText(
                            text: payment,
                            fontSize: 16,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      //Host Credit Reward
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Host Credit Reward",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textClr,
                          ),
                          CustomText(
                            text: nightStay.toString(),
                            fontSize: 16,
                            color: Color(0xffF59E0B),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                
                
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                Row(
                  children: [
                    Flexible(child: CustomButtonTwo(
                      onTap: (){
                        Get.back();
                      },
                      title: "Decline",fillColor: AppColors.red_02,)
                    ),
                    SizedBox(width: 16,),
                    Flexible(child: CustomButtonTwo(
                      onTap: (){

                       },
                       title: "Accept",fillColor: AppColors.primary,)
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
