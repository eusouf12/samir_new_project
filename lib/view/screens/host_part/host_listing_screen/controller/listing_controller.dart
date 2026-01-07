import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/listing_model.dart';

class ListingController extends GetxController {

  RxList<File> selectedImages = <File>[].obs;
  void addImage(File file) {
    selectedImages.add(file);
    debugPrint("Image added: ${selectedImages.length}");
  }
  void removeImage(int index) {
    selectedImages.removeAt(index);
    debugPrint("Image removed: ${selectedImages.length}");
  }

  //Text Controllers
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> titleDescriptionController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> airbnbController = TextEditingController().obs;

  RxMap<String, bool> amenities = <String, bool>{
    "wifi": false,
    "parking": false,
    "airConditioning": false,
    "pool": false,
    "tv": false,
    "kitchen": false,
    "petFriendly": false,
    "gym": false,
    "hotTub": false,
  }.obs;
  void toggleAmenity(String key, bool value) {
    amenities[key] = value;
    debugPrint("selected type = ${amenities[key]}");
  }
  var customAmenities = <String>[].obs;
  final TextEditingController customAmenityController = TextEditingController();

  void addCustomAmenity() {
    String name = customAmenityController.text.trim();
    if (name.isNotEmpty) {
      customAmenities.add(name); // ok
      customAmenityController.clear();
    }
  }

  //property type
  var selectedPropertyType = "".obs;
  final List<String> propertyTypes = [
    "Apartment",
    "Villa",
    "Hotel",
    "Resort",
    "Cabin",
    "Lodge"
  ];

  void updatePropertyType(String value) {
    selectedPropertyType.value = value;
  }

//============== post create Listing Controller===================
  RxBool createListingLoading = false.obs;
  Future<void> createListing() async {
    createListingLoading.value = true;
    refresh();
    try {
      Map<String, String> body = {
        "title": titleController.value.text.trim(),
        "description": titleDescriptionController.value.text.trim(),
        "location": locationController.value.text.trim(),
        "airbnbLink": airbnbController.value.text.trim(),
        "amenities": jsonEncode(amenities.map((k, v) => MapEntry(k, v))),
        "propertyType": selectedPropertyType.value,
        "customAmenities": customAmenities.join(","),
      };


      List<MultipartBody> multipartImages = [];

      for (int i = 0; i < selectedImages.length; i++) {
        multipartImages.add(MultipartBody(
            "images",selectedImages[i],
          ),);
      }
      debugPrint("body = $body");

      final response = await ApiClient.postMultipartData(ApiUrl.createListing, body, multipartBody: multipartImages);

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        createListingLoading.value = false;
        refresh();
        showCustomSnackBar(jsonResponse["message"] ?? "Listing created successfully", isError: false,);
        await getListings(loadMore: false);
        Get.back();
      } else {
        createListingLoading.value = false;
        refresh();
        showCustomSnackBar(jsonResponse["error"] ?? "Failed to create listing", isError: true);
      }
    } catch (e) {
      createListingLoading.value = false;
      refresh();
      showCustomSnackBar(
        "Something went wrong. Try again.",
        isError: true,
      );
      debugPrint("Create listing error: $e");
    }
  }

//============== post create Listing Controller===================
  RxList<ListingItem> listingList = <ListingItem>[].obs;

  final isListingLoading = false.obs;
  final isLoadMoreLoading = false.obs;

  final rxListingStatus = Status.loading.obs;
  void setListingStatus(Status status) => rxListingStatus.value = status;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> getListings({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMoreLoading.value) return;
      if (currentPage >= totalPages) return;

      isLoadMoreLoading.value = true;
      currentPage++;
    } else {
      isListingLoading.value = true;
      setListingStatus(Status.loading);
      currentPage = 1;
      listingList.clear();
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getListing(page: currentPage.toString()),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ListingsResponse model = ListingsResponse.fromJson(jsonResponse);

        totalPages = model.totalPages;

        // DUPLICATION CHECK HERE
        final existingIds = listingList.map((e) => e.id).toSet();

        for (final item in model.data.listings) {
          if (!existingIds.contains(item.id)) {
            listingList.add(item);
          }
        }

        setListingStatus(Status.completed);
      } else {
        setListingStatus(Status.error);
        Get.snackbar("Error", "Failed to load listings");
      }
    } catch (e) {
      setListingStatus(Status.error);
      Get.snackbar("Error", e.toString());
    } finally {
      isListingLoading.value = false;
      isLoadMoreLoading.value = false;
    }
  }


}
