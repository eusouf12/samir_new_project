import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samir_flutter_app/core/app_routes/app_routes.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/collabration_controller.dart';
import '../model/collaboration_single_model.dart';
import '../widget/status_task_card.dart';

class HostCollaborationViewDetailsScreen extends StatelessWidget {
  HostCollaborationViewDetailsScreen({super.key});
  final args = Get.arguments as Map<String, dynamic>;
  final CollaborationController controller = Get.put(CollaborationController());

  @override
  Widget build(BuildContext context) {
    if (controller.selectedCollaboration.value == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.currentStatus.value = args["status"] ?? "";
        controller.updatePaymentAmountColl.value = double.tryParse(args["payment"]?.toString() ?? "0") ?? 0.0;
        controller.updateNightsColl.value = args["nightStay"] ?? 0;
        controller.updatedDeliverables.assignAll(args["deliverables"] ?? []);
        controller.updateGuestColl.value = args["guestCount"] ?? 0;
        controller.fetchCollaborations(colId: args["collabrationId"]);
      });
    }

    final String image = args["image"] ?? "";
    final String name = args["name"] ?? "";
    final String userName = args["userName"] ?? "";
    final String listingName = args["listingName"] ?? "";
    final String inTimeAndDate = args["inTimeAndDate"] ?? "";
    final String outTimeAndDate = args["outTimeAndDate"] ?? "";
    final SingleUserAmenities? amenities = args["amenities"];
    final List socialMediaLinks = args["socialMediaLinks"] ?? [];
    final String userId = args["userId"] ?? "";
    final String collabrationId = args["collabrationId"] ?? "";
    final String role = args["role"] ;
    final bool isMe = args["isMe"] ;
    final String address = args["address"] ??"" ;
    final String myId = args["myId"] ;
    final String negotiationMessage = args["negotiationMessage"] ;
    final String influencerId = args["influencerId"] ;

    // Amenities List logic
    final List<String> enabledAmenities = [];
    if (amenities != null) {
      if (amenities.wifi) enabledAmenities.add("Wifi");
      if (amenities.kitchen) enabledAmenities.add("Kitchen");
      if (amenities.tv) enabledAmenities.add("TV");
      if (amenities.pool) enabledAmenities.add("Pool");
      if (amenities.airConditioning) enabledAmenities.add("AirConditioning");
      if (amenities.gym) enabledAmenities.add("Gym");
      if (amenities.parking) enabledAmenities.add("Parking");
      if (amenities.petFriendly) enabledAmenities.add("PetFriendly");
      if (amenities.hotTub) enabledAmenities.add("HotTub");
    }

    final List<SingleUserSocialMediaLinks> socialPosts = (args["socialMediaLinks"] as List?)?.map((e)
    {if (e is SingleUserSocialMediaLinks) {return e;
          } else if (e is Map<String, dynamic>) {return SingleUserSocialMediaLinks.fromJson(e);} else {
            return null;
          }}).whereType<SingleUserSocialMediaLinks>().toList() ?? [];

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request Details"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // User Profile Section
                Row(
                  children: [
                    CustomNetworkImage(imageUrl: image, height: 64, width: 64, boxShape: BoxShape.circle),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: name, fontSize: 14, fontWeight: FontWeight.w600),
                        CustomText(text: "@${userName}", fontSize: 12, fontWeight: FontWeight.w400),
                        role == "host" ?SizedBox.shrink(): Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on,size: 16,color: Colors.grey,),
                            CustomText(text: address, fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black26),
                          ],
                        ) ,
                        role == "host"
                        ?Row(
                          children: socialMediaLinks.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                children: [
                                  Icon(_getPlatformIcon(item.platform ?? ""), size: 18, color: _getPlatformColor(item.platform ?? "")),
                                  const SizedBox(width: 4),
                                  CustomText(text: item.followers ?? "0", fontSize: 13, fontWeight: FontWeight.w600),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                        :SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
               //'Collaboration Overview
                Obx(() => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Collaboration Overview", fontSize: 16, fontWeight: FontWeight.w600, bottom: 8),
                      _infoRow("Listing", listingName),
                      const SizedBox(height: 8),
                      _infoRow("Start Time", formatDate(inTimeAndDate)),
                      _infoRow("End Time", formatDate(outTimeAndDate)),
                      const SizedBox(height: 20),
                      const CustomText(text: "Deliverables", fontSize: 16, fontWeight: FontWeight.w600, bottom: 10),

                      // Deliverables List automatically updates now
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.updatedDeliverables.length,
                        itemBuilder: (context, index) {
                          final item = controller.updatedDeliverables[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text("${item.platform} - ${item.contentType} (${item.quantity})",
                                style: const TextStyle(fontWeight: FontWeight.w500)),
                          );
                        },
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 20),
                _amenitiesContainer(enabledAmenities),
               // =========offer ========
                const SizedBox(height: 20),
                Obx(() => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Offers", fontSize: 16, fontWeight: FontWeight.w600, bottom: 16),
                      _infoRowWithColor("Total Payment", "\$${controller.updatePaymentAmountColl.value}", AppColors.primary),
                      const SizedBox(height: 8),
                      _infoRowWithColor("Night Stay", "${controller.updateNightsColl.value}", const Color(0xffF59E0B)),
                      const SizedBox(height: 8),
                      controller.collabList.first.status == 'accepted' ?_infoRowWithColor("Host Payment", "${controller.collabList.first.paymentStatus}", const Color(0xffF59E0B)) : SizedBox.shrink(),
                    ],
                  ),
                )),
                //======= assigned contents ============
                Obx(() {
                  if (controller.currentStatus.value == 'pending') {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: _boxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(text: "Assigned Contents", fontSize: 16, fontWeight: FontWeight.w600, bottom: 16),
                            Obx(() {
                              if (controller.isCollabLoading.value) {
                                return Center(child: CustomLoader(color: role == 'host'? AppColors.primary : AppColors.primary2,),);
                              }

                              if (controller.collabList.isEmpty) {
                                return const CustomText(text: "No collaboration found", fontSize: 14, fontWeight: FontWeight.w400,);
                              }

                              final collab = controller.collabList.first;
                              final deliverables = collab.deliverables ?? [];

                              if (deliverables.isEmpty) {
                                return const CustomText(
                                  text: "No assigned content yet",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: deliverables.length,
                                itemBuilder: (context, index) {
                                  final item = deliverables[index];

                                  final int urlCount = item.urls?.length ?? 0;
                                  final int requiredQuantity = item.quantity ?? 0;
                                  final bool isSubmitted = urlCount >= requiredQuantity && requiredQuantity != 0;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: StatusTaskCard(
                                      title: "${item.platform ?? ""} - ${item.contentType ?? ""} ($urlCount/$requiredQuantity)",
                                      isSubmitted: isSubmitted,
                                      onEditTap: () {
                                        showSubmitDialog(
                                            context,
                                            item.platform ?? "Unknown",
                                            item.contentType ?? "Unknown",
                                            collab.id ?? ""
                                        );
                                      }, status: collab.status ?? ""
                                        "",
                                    ),
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  );
                }),

                //======= btn
                const SizedBox(height: 20),
                Obx(() {
                  final status = controller.currentStatus.value;
                  return Column(
                    children: [
                      (status == "ongoing" || status == "rejected" || status == "accepted"|| status == "completed")
                          ? const SizedBox.shrink()
                          : Row(
                        children: [
                          Flexible(child: CustomButtonTwo(
                              onTap: ()  async {
                                final id = await SharePrefsHelper.getString(AppConstants.userId);
                                controller.getSingleUser(userId: id);
                                controller.acceptRejected(action: 'reject', userId: myId, collabrationId: collabrationId);
                              },
                              title: "Decline", fillColor: AppColors.red_02,fontSize: 14,)),
                          const SizedBox(width: 10),
                          (isMe == false && status != "negotiating" || (isMe == true && status == "negotiating"))?
                          Flexible(child: CustomButtonTwo(
                              onTap: () async {
                                final id = await SharePrefsHelper.getString(AppConstants.userId);
                                controller.getSingleUser(userId: id);
                                controller.acceptRejected(action: 'accept', userId: userId, collabrationId: collabrationId);
                              },title: "Accept", fillColor: role == "host" ? AppColors.primary : AppColors.primary2,fontSize: 14,))
                              :SizedBox.shrink(),
                        ],
                      ),

                      const SizedBox(height: 10),
                      //negotiation
                      (isMe == false)?
                      (status == "ongoing" || status == "rejected" || status == "accepted" || status == "completed" ||status == "negotiating")
                          ? const SizedBox.shrink()
                          : CustomButtonTwo(
                          onTap: () => Get.toNamed(AppRoutes.negotiationScreen, arguments:{ 'collaborationId': collabrationId, 'role': role, 'negotiationMessage': negotiationMessage, 'influencerId':influencerId}),
                          title: "Request to Negotiation", fillColor: role == "host" ? AppColors.primary : AppColors.primary2,fontSize: 14)
                          :SizedBox.shrink(),
                      const SizedBox(height: 10),
                      (status == "accepted" && role =="host") ?
                      CustomButtonTwo(
                          onTap: () async {
                            final id = await SharePrefsHelper.getString(AppConstants.userId);
                            controller.getSingleUser(userId: id );
                            controller.hostPayment(colId: collabrationId);
                          },
                          title: "Make Payment", fillColor: role == "host" ? AppColors.primary : AppColors.primary2,fontSize: 14
                      )
                          : const SizedBox.shrink(),
                      //give review and report and night credit
                      (status == "completed" ) ?
                      Row(
                        children: [
                          Flexible(child: CustomButtonTwo(
                              onTap: ()  async {
                                // final id = await SharePrefsHelper.getString(AppConstants.userId);
                                // controller.getSingleUser(userId: id);
                                // controller.acceptRejected(action: 'reject', userId: myId, collabrationId: collabrationId);
                              },
                              title: " Give Review", fillColor: AppColors.primary,borderColor: role == "host" ? AppColors.primary : AppColors.primary2,isBorder: true,fontSize: 14)
                          ),
                          const SizedBox(width: 10),
                          Flexible(child: CustomButtonTwo(
                              onTap: () async {
                                // final id = await SharePrefsHelper.getString(AppConstants.userId);
                                // controller.getSingleUser(userId: id);
                                // controller.acceptRejected(action: 'accept', userId: userId, collabrationId: collabrationId);
                              },title: "Report", fillColor:AppColors.red,fontSize: 14))

                        ],
                      ) :
                      const SizedBox.shrink(),
                      const SizedBox(height: 10),
                      (status == "completed" && role =='host') ?
                      CustomButtonTwo(
                              onTap: ()  async {
                                // final id = await SharePrefsHelper.getString(AppConstants.userId);
                                // controller.getSingleUser(userId: id);
                                // controller.acceptRejected(action: 'reject', userId: myId, collabrationId: collabrationId);
                              },
                              title: " Give Night Credits",fontSize: 14, fillColor: AppColors.primary,borderColor: role == "host" ? AppColors.primary : AppColors.primary2,isBorder: true,)
                          : const SizedBox.shrink()

                    ],
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }


  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: label, fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textClr),
        CustomText(text: value, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _infoRowWithColor(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: label, fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textClr),
        CustomText(text: value, fontSize: 16, color: color, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _amenitiesContainer(List<String> amenities) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: "Amenities", fontSize: 16, fontWeight: FontWeight.w600, bottom: 12),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: amenities.map((amenity) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: CustomText(text: amenity, fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String formatDate(String isoDate) {
    if (isoDate.isEmpty) return "";
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('MMM dd, yyyy').format(parsedDate);
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram': return Icons.camera_alt;
      case 'facebook': return Icons.facebook;
      case 'tiktok': return Icons.music_note;
      case 'youtube': return Icons.play_circle_fill;
      default: return Icons.public;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram': return const Color(0xFFE1306C);
      case 'facebook': return const Color(0xFF1877F2);
      case 'youtube': return const Color(0xFFFF0000);
      default: return AppColors.primary;
    }
  }
  //link submit
  void showSubmitDialog(BuildContext context, String platform, String contentType,String collabrationId) {
    final TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(text: "Submit Link for $platform", fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.black,textAlign: TextAlign.start,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "Type: $contentType", fontSize: 12, fontWeight: FontWeight.w600, textAlign: TextAlign.start,),
            const SizedBox(height: 10),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                hintText: "Enter your content URL here",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: CustomText(text: "Cancel", fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black,),),
          ElevatedButton(
            onPressed: () {
               controller.submitLinkColleboration(collabrationId: collabrationId, urls: [urlController.text], platform: platform, contentType: contentType);
              Navigator.pop(context);
            },
            child: CustomText(text: "Submit", fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary2,),
          )
        ],
      ),
    );
  }
}
