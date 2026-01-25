import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../host_profile_screen/controller/host_profile_controller.dart';
import '../model/listing_model.dart';

class ListingController extends GetxController {

  final HostProfileController hostProfileController = Get.put(HostProfileController());

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
        "addAirbnbLink": airbnbController.value.text.trim(),
        "amenities": jsonEncode(amenities.map((k, v) => MapEntry(k, v))),
        "propertyType": selectedPropertyType.value,
        "customAmenities": customAmenities.join(","),
      };


      List<MultipartBody> multipartImages = [];

      for (int i = 0; i < selectedImages.length; i++) {
        multipartImages.add(MultipartBody("images",selectedImages[i]),);
      }
      debugPrint("body = $body");

      final response = await ApiClient.postMultipartData(ApiUrl.createListing, body, multipartBody: multipartImages);

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        createListingLoading.value = false;
        refresh();
        showCustomSnackBar(jsonResponse["message"] ?? "Listing created successfully", isError: false,);
        clearFormData();
        await getListings(loadMore: false);
        hostProfileController.getUserProfile();
        refresh();
        Get.back();
      } else {
        createListingLoading.value = false;
        refresh();
        showCustomSnackBar(jsonResponse["error"] ?? "Failed to create listing", isError: true);
      }
    } catch (e) {
      createListingLoading.value = false;
      refresh();
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Create listing error: $e");
    }
  }
  //============== clear Function===================
  void clearFormData() {
    titleController.value.clear();
    titleDescriptionController.value.clear();
    locationController.value.clear();
    airbnbController.value.clear();
    amenities.updateAll((key, value) => false);
    selectedPropertyType.value = "";
    customAmenities.clear();
    selectedImages.clear();
  }

//==============searchQuery===================
  RxString searchQuery = ''.obs;
  RxList<ListingItem> searchListingList = <ListingItem>[].obs;

  final rxSearchListingStatus = Status.loading.obs;
  void setSearchListingStatus(Status status) => rxSearchListingStatus.value = status;

  Future<void> searchMyListing({required String query}) async {
    setSearchListingStatus(Status.loading);
    searchListingList.clear();

    try {
      final response = await ApiClient.getData(ApiUrl.listingSearch(listSearch: query));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ListingsResponse model = ListingsResponse.fromJson(jsonResponse);

        // Filter by query
        final filteredListings = model.data.listings.where((listing) {
          return listing.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

        searchListingList.assignAll(filteredListings);

        setSearchListingStatus(Status.completed);
      } else {
        setSearchListingStatus(Status.error);
        showCustomSnackBar("Failed to search listings", isError: true);
      }
    } catch (e) {
      setSearchListingStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }



// ==============Get Listing Controller===================
  RxList<ListingItem> listingList = <ListingItem>[].obs;

  final isListingLoading = false.obs;
  final isLoadMoreLoading = false.obs;
  final rxListingStatus = Status.loading.obs;
  void setListingStatus(Status status) => rxListingStatus.value = status;
  int currentPage = 1;
  int totalPages = 1;

  Future<void> getListings({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMoreLoading.value || currentPage >= totalPages) return;
      isLoadMoreLoading.value = true;
      currentPage++;
    } else {
      isListingLoading.value = true;
      setListingStatus(Status.loading);
      currentPage = 1;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getListing(page: currentPage.toString()),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ListingsResponse model = ListingsResponse.fromJson(jsonResponse);

        totalPages = model.totalPages;

        // Add new items if not duplicate
        final existingIds = listingList.map((e) => e.id).toSet();
        for (final item in model.data.listings) {
          if (!existingIds.contains(item.id)) {
            listingList.add(item);
          }
        }


        setListingStatus(Status.completed);
      } else {
        setListingStatus(Status.error);
        showCustomSnackBar("Failed to load listings", isError: true);
      }
    } catch (e) {
      setListingStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isListingLoading.value = false;
      isLoadMoreLoading.value = false;
    }
  }

  // ================= Single Get Listing =================
  RxList<ListingItem> singleListingList = <ListingItem>[].obs;
  final rxSingleListingStatus = Status.loading.obs;
  void setSingleListingStatus(Status status) => rxSingleListingStatus.value = status;

  // Future<void> singleGetListing({required String id}) async {
  //   setSingleListingStatus(Status.loading);
  //   singleListingList.clear();
  //
  //   try {
  //     final response =
  //     await ApiClient.getData(ApiUrl.getSingleListing(id: id));
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
  //
  //       final List listingsJson = jsonResponse['data']['listings'];
  //       final ListingItem listing = ListingItem.fromJson(listingsJson.first);
  //       //==================== update variable setup ==================
  //       updateTitleController.value.text = listing.title;
  //       updateTitleDescriptionController.value.text = listing.description;
  //       updateLocationController.value.text = listing.location;
  //       updateAirbnbController.value.text = listing.addAirbnbLink;
  //       updateSelectedPropertyType.value = listing.propertyType;
  //       updateAmenities.updateAll((key, value) => listing.amenities[key] ?? false,);
  //       updateCustomAmenities.assignAll(listing.customAmenities);
  //       updateImageUrls.assignAll(listing.images);
  //       //================= end update ======================
  //       singleListingList.assignAll([listing]);
  //
  //       setSingleListingStatus(Status.completed);
  //     } else {
  //       setSingleListingStatus(Status.error);
  //       showCustomSnackBar("Failed to load listing", isError: true);
  //     }
  //   } catch (e) {
  //     setSingleListingStatus(Status.error);
  //     showCustomSnackBar("Error: ${e.toString()}", isError: true);
  //   }
  // }

// ================= Single Get Listing =================
  Future<void> singleGetListing({required String id}) async {
    setSingleListingStatus(Status.loading);
    singleListingList.clear();

    try {
      final response =
      await ApiClient.getData(ApiUrl.getSingleListing(id: id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final List listings = jsonResponse['data']['listing'];

        // 🔥 FIX JSON FIRST
        final Map<String, dynamic> fixedJson =
        Map<String, dynamic>.from(listings.first);

        fixedJson['images'] = (fixedJson['images'] as List? ?? [])
            .map((img) => img.toString().startsWith('http')
            ? img.toString()
            : ApiUrl.baseUrl + img.toString())
            .toList();

        // ✅ Create model ONCE
        final ListingItem listing = ListingItem.fromJson(fixedJson);

        // Prefill update controllers
        updateTitleController.value.text = listing.title;
        updateTitleDescriptionController.value.text = listing.description;
        updateLocationController.value.text = listing.location;
        updateAirbnbController.value.text = listing.addAirbnbLink;
        updateSelectedPropertyType.value = listing.propertyType;

        updateAmenities.updateAll(
              (key, value) => listing.amenities[key] ?? false,
        );

        updateCustomAmenities.assignAll(listing.customAmenities);
        updateImageUrls.assignAll(listing.images);

        singleListingList.assignAll([listing]);

        setSingleListingStatus(Status.completed);
      } else {
        setSingleListingStatus(Status.error);
      }
    } catch (e) {
      setSingleListingStatus(Status.error);
      debugPrint("singleGetListing error: $e");
    }
  }
 ///////////// ========== update ==================
  // ================== UPDATE CONTROLLERS ==================
  Rx<TextEditingController> updateTitleController =
      TextEditingController().obs;
  Rx<TextEditingController> updateTitleDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> updateLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> updateAirbnbController =
      TextEditingController().obs;


  var updateSelectedPropertyType = ''.obs;


  RxMap<String, bool> updateAmenities = <String, bool>{
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


  RxList<String> updateCustomAmenities = <String>[].obs;
  RxList<String> updateImageUrls = <String>[].obs;
  RxList<File> updateSelectedImages = <File>[].obs;


  final isUpdateListingLoading = false.obs;

  // ================== UPDATE LISTING ==================
  Future<void> updateListing({required String listingId}) async {
    isUpdateListingLoading.value = true;
    refresh();

    try {
// ---- BODY (ALWAYS MULTIPART) ----
      final Map<String, String> body = {
        "title": updateTitleController.value.text.trim(),
        "description": updateTitleDescriptionController.value.text.trim(),
        "location": updateLocationController.value.text.trim(),
        "addAirbnbLink": updateAirbnbController.value.text.trim(),
        "propertyType": updateSelectedPropertyType.value,


// IMPORTANT
        "amenities": jsonEncode(updateAmenities),
        "customAmenities": updateCustomAmenities.join(","),


// old images if backend uses them
        //"existingImages": jsonEncode(updateImageUrls),
      };


      final response = await ApiClient.putMultipartData(
        ApiUrl.updateListing(id: listingId),
        body,
        multipartBody: updateSelectedImages
            .map((file) => MultipartBody("images", file))
            .toList(),
      );


      isUpdateListingLoading.value = false;
      refresh();


      final Map<String, dynamic> jsonResponse =
      response.body is String
          ? jsonDecode(response.body)
          : Map<String, dynamic>.from(response.body);


      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ??
              "Listing updated successfully!",
          isError: false,
        );


        Get.back(result: true);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Update failed",
          isError: true,
        );
      }
    } catch (e) {
      isUpdateListingLoading.value = false;
      refresh();
      debugPrint("Update listing error: $e");
      showCustomSnackBar(
        "An error occurred. Please try again.",
        isError: true,
      );
    }
  }
}
