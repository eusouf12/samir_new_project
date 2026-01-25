import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

                // PHOTOS
                _photoUploadBox(),

                const SizedBox(height: 24),

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
                      final res = listingController.updateListing(
                        listingId: listingId,
                      );
                      if (res == true) {
                        listingController.getListings();
                        listingController.singleGetListing(id: listingId);
                      }
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

  // ================= PHOTOS =================
  Widget _photoUploadBox() {
    return Obx(() {
      final urls = listingController.updateImageUrls;
      final files = listingController.updateSelectedImages;

      final total = urls.length + files.length;

      if (total == 0) {
        return _defaultUploadBox();
      }

      return SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: total + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            if (index == total) {
              return _addMoreBox();
            }

            // OLD IMAGE (URL)
            if (index < urls.length) {
              return _imageTile(
                child: Image.network(
                  urls[index],
                  fit: BoxFit.cover,
                ),
                onRemove: () =>
                    listingController.updateImageUrls.removeAt(index),
              );
            }

            // NEW IMAGE (FILE)
            final fileIndex = index - urls.length;
            return _imageTile(
              child: Image.file(
                files[fileIndex],
                fit: BoxFit.cover,
              ),
              onRemove: () =>
                  listingController.updateSelectedImages
                      .removeAt(fileIndex),
            );
          },
        ),
      );
    });
  }

  Widget _imageTile({
    required Widget child,
    required VoidCallback onRemove,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(width: 120, height: 120, child: child),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addMoreBox() {
    return GestureDetector(
      onTap: () =>
          Get.find<ImagePickerController>().pickFromGallery(),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }

  Widget _defaultUploadBox() {
    return ElevatedButton(
      onPressed: () =>
          Get.find<ImagePickerController>().pickFromGallery(),
      child: const Text("Choose Images"),
    );
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