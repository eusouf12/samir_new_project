import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/listing_model.dart';


class ListingCard extends StatelessWidget {
  final ListingItem listing;
  final VoidCallback? onTapAirbnb;

   ListingCard({
    Key? key,
    required this.listing,
    this.onTapAirbnb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============= Image =============
          CustomNetworkImage(
             imageUrl: listing.images.isNotEmpty ? ApiUrl.baseUrl + listing.images.first : "",
            height: 220,
            width: MediaQuery.sizeOf(context).width,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============= Title + Verified Badge ===========
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: listing.title,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    // listing.status == "Pending"
                    //     ? Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    //     decoration: BoxDecoration(
                    //     color: AppColors.primary,
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: const CustomText(
                    //     text: "pending",
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: AppColors.white,
                    //   ),
                    // )
                    //     :Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xffFFEDD5),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: const CustomText(
                    //     text: "Verified",
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: AppColors.red,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8),

                // ============= Location ===========
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 18,),
                    const SizedBox(width: 6),
                    CustomText(
                      text: listing.location,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // ============= Description ===========
                CustomText(
                  text: listing.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  maxLines: 6,
                  textAlign: TextAlign.start,
                  bottom: 8,
                ),

                // ============= Default Amenities ===========
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: listing.amenities.entries.where((e) => e.value).map((e) =>
                      Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E7EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icons[e.key] ?? Icons.done,
                            size: 16.sp,
                            color: const Color(0xff4B5563),
                          ),
                          const SizedBox(width: 6),
                          CustomText(
                            text: _amenityLabel(e.key),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff1F2937),
                          ),
                        ],
                      ),
                    ),
                  )
                      .toList(),
                ),
                const SizedBox(height: 8),

                // ============= Custom Amenities ===========
                if (listing.customAmenities.isNotEmpty && listing.customAmenities.first.isNotEmpty) ...[
                  CustomText(
                    text: "Additional Amenities",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    bottom: 6,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: listing.customAmenities.first
                        .split(",")
                        .map(
                          (e) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xffE5E7EB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomText(
                          text: e.trim(),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                ],

                // ============= Airbnb Link ===========
                GestureDetector(
                  onTap: onTapAirbnb,
                  child: Card(
                    elevation: 0,
                    color: AppColors.white,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F4F6),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: "View Listing on Airbnb",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            right: 8,
                          ),
                          const CustomImage(imageSrc: AppIcons.linkIcon),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Convert backend keys to readable labels
  String _amenityLabel(String key) {
    switch (key) {
      case "wifi":
        return "Wi-Fi";
      case "pool":
        return "Pool";
      case "kitchen":
        return "Kitchen";
      case "parking":
        return "Parking";
      case "airConditioning":
        return "AC";
      case "tv":
        return "TV";
      case "gym":
        return "Gym";
      case "petFriendly":
        return "Pet Friendly";
      case "hotTub":
        return "Hot Tub";
      default:
        return key;
    }
  }
  final Map<String, IconData> icons = {
    "wifi": Icons.wifi,
    "parking": Icons.directions_car,
    "airConditioning": Icons.ac_unit,
    "pool": Icons.pool,
    "tv": Icons.tv,
    "kitchen": Icons.kitchen,
    "petFriendly": Icons.pets,
    "gym": Icons.fitness_center,
    "hotTub": Icons.hot_tub,
  };
}
