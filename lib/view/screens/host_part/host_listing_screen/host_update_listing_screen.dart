import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/service/api_url.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../authentication/controller/pic_image_gallery_camera_controller.dart';
import 'controller/listing_controller.dart';

class HostUpdateListingScreen extends StatelessWidget {
  HostUpdateListingScreen({super.key});
  final listingId = Get.arguments;

  final ListingController listingController = Get.put(ListingController());
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());

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

  final Map<String, String> labels = {
    "wifi": "Wi-Fi",
    "parking": "Parking",
    "airConditioning": "AC",
    "pool": "Pool",
    "tv": "TV",
    "kitchen": "Kitchen",
    "petFriendly": "Pet Friendly",
    "gym": "Gym",
    "hotTub": "Hot Tub",
  };

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listingController.singleGetListing(id: listingId);
    });
    return CustomGradient(
      child: Scaffold(
        appBar: const CustomRoyelAppbar(leftIcon: true, titleName: "Update Listing",),
        body: Obx(() {
          if (listingController.rxSingleListingStatus.value == Status.loading) {
            return const CustomLoader();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomNetworkImage(imageUrl:ApiUrl.baseUrl + listingController.updateImageUrls[0],borderRadius: BorderRadius.circular(16),),
                SizedBox(height: 20),
                //TITLE
                CustomFormCard(
                  title: "Listing Title",
                  controller:
                  listingController.updateTitleController.value,
                ),
                // DESCRIPTION
                CustomFormCard(
                  title: "Description",
                  maxLine: 3,
                  controller: listingController
                      .updateTitleDescriptionController.value,
                ),
                // LOCATION
                CustomFormCard(
                  title: "Location",
                  prefixIcon: const Icon(Icons.location_on),
                  controller:
                  listingController.updateLocationController.value,
                ),
                // AIRBNB
                CustomFormCard(
                  title: "Airbnb Link",
                  prefixIcon: const Icon(Icons.link),
                  controller:
                  listingController.updateAirbnbController.value,
                ),

                const SizedBox(height: 16),
                // PROPERTY TYPE
                _propertyTypeDropdown(),

                const SizedBox(height: 20),

                /// AMENITIES
                _amenitiesSection(),

                const SizedBox(height: 30),

                // UPDATE BUTTON
                Obx(() {
                  if (listingController.isUpdateListingLoading.value) {
                    return const CustomLoader();
                  }

                  return CustomButton(
                    title: "Update Listing",
                    onTap: () {
                      listingController.updateListing(listingId: listingId);
                    },
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ================= PROPERTY TYPE =================
  Widget _propertyTypeDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
      value: listingController.updateSelectedPropertyType.value.isEmpty
          ? null
          : listingController.updateSelectedPropertyType.value,
      hint: const Text("Select property type"),
      dropdownColor: Colors.white,
      items: listingController.propertyTypes.map((type) => DropdownMenuItem(
        value: type,
        child: Text(type),
      ))
          .toList(),
      onChanged: (val) {
        if (val != null) {listingController.updateSelectedPropertyType.value = val;}
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 👈 radius here
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 👈 and here
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 👈 and here
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    ));
  }

  // ================= AMENITIES =================
  Widget _amenitiesSection() {
    return Obx(() => Column(
      children: [
        _row(["wifi", "parking"]),
        _row(["airConditioning", "pool"]),
        _row(["tv", "kitchen"]),
        _row(["petFriendly", "gym"]),
        _row(["hotTub"]),
      ],
    ));
  }

  Widget _row(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: CheckboxListTile(
            value:
            listingController.updateAmenities[key] ?? false,
            onChanged: (val) {
              listingController.updateAmenities[key] =
                  val ?? false;
            },
            activeColor: AppColors.primary,
            title: Text(labels[key] ?? key),
            secondary:
            Icon(icons[key] ?? Icons.check_box,color: AppColors.primary,),
          ),
        );
      }).toList(),
    );
  }
}