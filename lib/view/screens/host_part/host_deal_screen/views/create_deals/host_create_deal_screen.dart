import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_listing_screen/controller/listing_controller.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../controller/deals_controller.dart';

class HostCreateDealScreen extends StatelessWidget {
  HostCreateDealScreen({super.key});
  final DealsController dealsController = Get.put(DealsController());
  final ListingController listingController = Get.put(ListingController());
  final args = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final String page = args['page'];
    final String id = args['id'] ;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listingController.getVerifiedListings(loadMore: false);
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  CustomRoyelAppbar(leftIcon: true, titleName: page == "deal" ? "Create Deal" : "Create Collaboration"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============ Progress ============
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffeff9f8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Step 1 of 4", fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary, bottom: 6),
                  const CustomText(text: "Deal Basics", fontSize: 16, fontWeight: FontWeight.w700, bottom: 6),
                  LinearProgressIndicator(
                    value: 0.25,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                    backgroundColor: Colors.grey.shade300,
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Title
                  const CustomText(text: "Title", fontSize: 14, fontWeight: FontWeight.w600, bottom: 8),
                  Obx(() => GestureDetector(
                    onTap: () {
                      if (listingController.verifiedListingList.isEmpty) {
                        listingController.getVerifiedListings();
                      }
                      _openListingDropdown(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              dealsController.selectedTitle.value.isEmpty
                                  ? "Select property type"
                                  : dealsController.selectedTitle.value,
                              style: TextStyle(
                                fontSize: 16,
                                color: dealsController.selectedTitle.value.isEmpty
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
                        ],
                      ),
                    ),
                  )),

                  SizedBox(height: 16),
                  //  Description
                  CustomFormCard(
                    title: "Description",
                    hintText: "Description what you expect from the influencer....",
                    maxLine: 3,
                    controller: dealsController.titleDescriptionController.value,
                  ),
                  buildDateTimeRow("Check In", isCheckIn: true,),
                  buildDateTimeRow("Check Out", isCheckIn: false,),
                  const SizedBox(height: 16),
                  const SizedBox(height: 50),
                  CustomButtonTwo(
                    onTap: () {
                      debugPrint("page == ${page} == id = ${id}");
                      debugPrint('Selected title: ${dealsController.selectedTitle.value}');
                      debugPrint('Description: ${dealsController.titleDescriptionController.value.text}');
                      debugPrint('Check-in date: ${dealsController.checkInFormattedDate}');
                      debugPrint('Check-in time: ${dealsController.checkInFormattedTime}');
                      debugPrint('Check-out date: ${dealsController.checkOutFormattedDate}');
                      debugPrint('Check-out time: ${dealsController.checkOutFormattedTime}');
                      Get.toNamed(AppRoutes.hostCreateDealTwoScreen,arguments: {"page": page, "id": id});
                    },
                    title: "Next →",
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDateTimeRow(String label, {required bool isCheckIn}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          bottom: 8,
        ),
        Row(
          children: [
            // TIME PICKER
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Time",
                    fontSize: 14.sp,
                    color: Colors.black,
                    bottom: 4,
                  ),
                  GestureDetector(
                    onTap: () => dealsController.pickTime(
                      Get.context!,
                      isCheckIn: isCheckIn,
                    ),
                    child: Obx(() {
                      final hasTime = isCheckIn
                          ? dealsController.checkInTime.value != null
                          : dealsController.checkOutTime.value != null;

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300, width: 1.5,),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isCheckIn
                                  ? dealsController.checkInFormattedTime
                                  : dealsController.checkOutFormattedTime,
                              style: TextStyle(color: hasTime ? AppColors.black : Colors.black54,),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down, color: AppColors.primary,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // DATE PICKER
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Date",
                    fontSize: 14.sp,
                    color: Colors.black,
                    bottom: 4,
                  ),
                  GestureDetector(
                    onTap: () => dealsController.pickDate(
                      Get.context!,
                      isCheckIn: isCheckIn,
                    ),
                    child: Obx(() {
                      final hasDate = isCheckIn ? dealsController.checkInDate.value != null : dealsController.checkOutDate.value != null;

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:  Colors.grey.shade300, width: 1.5,),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined, color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCheckIn ? dealsController.checkInFormattedDate : dealsController.checkOutFormattedDate,
                              style: TextStyle(
                                color: hasDate ? Colors.black : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openListingDropdown(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Listing Dropdown",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (listingController.verifiedListingList.isEmpty &&
                          listingController.isVerifiedListingLoading.value) {
                        return const Center(child: CustomLoader());
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !listingController.isVerifiedLoadMoreLoading.value) {
                            listingController.getVerifiedListings(loadMore: true);
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: listingController.verifiedListingList.length + (listingController.isVerifiedLoadMoreLoading.value ? 1 : 0),
                          separatorBuilder: (_, __) =>
                          const Divider(height: 1,color: Colors.white,),

                          itemBuilder: (context, index) {
                            if (index == listingController.verifiedListingList.length) {
                              return const Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(child: CustomLoader()),
                              );
                            }
                            final item = listingController.verifiedListingList[index];
                            return ListTile(
                              title: Text(item.title, style: const TextStyle(fontSize: 15),),
                              onTap: () {
                                dealsController.selectedId.value = item.id;
                                dealsController.selectedTitle.value = item.title;
                                dealsController.selectedAirbnbLink.value = item.addAirbnbLink;

                                debugPrint("Selected ID: ${item.id}");
                                debugPrint("Selected Title: ${item.title}");
                                debugPrint("Selected Airbnb: ${item.addAirbnbLink}");

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}