import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../authentication/controller/pic_image_gallery_camera_controller.dart';
import 'controller/listing_controller.dart';

class HostAddNewListingScreen extends StatelessWidget {
  HostAddNewListingScreen({super.key});

  final ListingController listingController = Get.put(ListingController());
  final ImagePickerController imagePickerController =
  Get.put(ImagePickerController());

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
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Add New Listing",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              //title
              CustomFormCard(
                title: "Listing Title",
                hintText: "Dhaka",
                controller: listingController.titleController.value,
              ),
              //des
              CustomFormCard(
                title: "Description",
                maxLine: 3,
                hintText:
                "Describe your property, nearby, attractions, and key details…",
                controller:
                listingController.titleDescriptionController.value,
              ),
              //location
              CustomFormCard(
                title: "Location",
                hintText: "Dhaka",
                prefixIcon:
                Icon(Icons.location_on, color: AppColors.textClr),
                controller: listingController.locationController.value,
              ),
              //airbnb link
              CustomFormCard(
                title: "Airbnb Link",
                hintText: "https://airbnb.com/...",
                prefixIcon: Icon(Icons.link, color: AppColors.red),
                controller: listingController.airbnbController.value,
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label: Property Type *
                Row(
                  children: [
                    CustomText(text: 'Property Type ',fontSize: 16.sp, fontWeight: FontWeight.w500),
                    CustomText(text: '*',fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.red),
                  ]
                ),
                SizedBox(height: 8.h),

                // Dropdown Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,),
                  child: Obx(() => DropdownButtonFormField<String>(
                    value: listingController.selectedPropertyType.value.isEmpty
                        ? null
                        : listingController.selectedPropertyType.value,
                    hint:CustomText(text: 'Select property type ',fontSize: 14.sp, color: Colors.grey,fontWeight: FontWeight.w500),
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20.sp),

                    dropdownColor: Colors.white,
                    menuMaxHeight: 300.h,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFF00796B)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),

                    items: listingController.propertyTypes.map((String type) {
                      bool isSelected = listingController.selectedPropertyType.value == type;
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            type,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    selectedItemBuilder: (BuildContext context) {
                      return listingController.propertyTypes.map((String type) {
                        return Text(type, style: const TextStyle(color: Colors.black));
                      }).toList();
                    },

                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        listingController.updatePropertyType(newValue);
                      }
                    },
                  )),
                )
              ],
            ),
      
              const SizedBox(height: 16),
      
              // -------- Photos
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Photos",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              _photoUploadBox(context),
      
              const SizedBox(height: 28),
      
              // -------- Amenities
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Amenities",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _amenitiesSection(),
      
              const SizedBox(height: 10),
              Obx(() {
                if (listingController.createListingLoading.value) {
                  return const CustomLoader();
                }
      
                return CustomButton(onTap: (){
                  listingController.createListing();
                },
                  title: "Create Listing",
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoUploadBox(BuildContext context) {
    return Obx(() {
      final images = listingController.selectedImages;

      // NO IMAGE → default upload box
      if (images.isEmpty) return _defaultUploadBox();

      // SINGLE IMAGE → Full preview
      if (images.length == 1) {
        return GestureDetector(
          onTap: () {
            // Get.to(() => FullScreenImageView(imageFile: images.first));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Image.file(
                  images.first,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _removeButton(() => listingController.removeImage(0)),
                ),
              ],
            ),
          ),
        );
      }

      // MULTIPLE IMAGES → Horizontal scroll + add more
      return SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: images.length + 1, // extra for Add More
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            if (index == images.length) {
              return GestureDetector(
                onTap: () => Get.find<ImagePickerController>().pickFromGallery(),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(Icons.add, size: 40, color: Colors.grey),
                ),
              );
            }

            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    images[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: _removeButton(() => listingController.removeImage(index)),
                ),
              ],
            );
          },
        ),
      );
    });
  }
  Widget _removeButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        radius: 12,
        backgroundColor: Colors.black54,
        child: Icon(Icons.close, size: 14, color: Colors.white),
      ),
    );
  }
  Widget _defaultUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey.shade500),
          const SizedBox(height: 10),
          const Text(
            "Upload property photos\nPNG, JPG up to 10MB",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.find<ImagePickerController>().pickFromGallery(),
            child: const Text("Choose Files"),
          ),
        ],
      ),
    );
  }
  // AMENITIES (REACTIVE FIX)
  Widget _amenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
            text: "Amenities & Features",
            fontSize: 16,
            fontWeight: FontWeight.bold),
        SizedBox(height: 16.h),

        Obx(() => Column(
          children: [
            _row(["wifi", "parking"]),
            _row(["airConditioning", "pool"]),
            _row(["tv", "kitchen"]),
            _row(["petFriendly", "gym"]),
            _row(["hotTub"]),
          ],
        )),
        Obx(() => Wrap(
          spacing: 8,
          children: listingController.customAmenities.map((name) {
            return Chip(
              label: Text(name, style: TextStyle(fontSize: 12.sp)),
              deleteIcon: const Icon(Icons.cancel, size: 16, color: Colors.red),
              onDeleted: () => listingController.customAmenities.remove(name),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: listingController.customAmenityController,
                decoration: InputDecoration(
                  hintText: "Enter custom amenity name",
                  hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => listingController.addCustomAmenity(),
              child: Container(
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),

        SizedBox(height: 30.h),
      ],
    );
  }
  Widget _row(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: keys.map((key) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      activeColor: AppColors.primary,
                      // ফিক্স: ভ্যালু নাল হলে false হবে
                      value: listingController.amenities[key] ?? false,
                      onChanged: (val) {
                        listingController.toggleAmenity(key, val ?? false);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(icons[key] ?? Icons.check_box_outline_blank,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      labels[key] ?? key,
                      style: TextStyle(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
