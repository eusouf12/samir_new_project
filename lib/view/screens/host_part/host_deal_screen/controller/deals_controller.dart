import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../collaboration_screen/controller/collabration_controller.dart';
import '../../host_listing_screen/model/listing_model.dart';
import '../deal_model/deal_model.dart';

final CollaborationController collaborationController = Get.put(CollaborationController());

class DealsController extends GetxController {
  RxList<ListingItem> listingList = <ListingItem>[].obs;
  RxString selectedTitle = ''.obs;
  RxString selectedId = ''.obs;
  RxString selectedAirbnbLink = ''.obs;

  Rx<TextEditingController> titleDescriptionController = TextEditingController().obs;
  // CHECK IN
  Rx<TimeOfDay?> checkInTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> checkInDate = Rx<DateTime?>(null);
  // CHECK OUT
  Rx<TimeOfDay?> checkOutTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);

  String get checkInFormattedTime => checkInTime.value == null ? "Select time" : checkInTime.value!.format(Get.context!);
  String get checkOutFormattedTime => checkOutTime.value == null ? "Select time" : checkOutTime.value!.format(Get.context!);
  String get checkInFormattedDate => checkInDate.value == null ? "Select date" : DateFormat('dd MMM yyyy').format(checkInDate.value!);
  String get checkOutFormattedDate => checkOutDate.value == null ? "Select date" : DateFormat('dd MMM yyyy').format(checkOutDate.value!);

  Future<void> pickTime(BuildContext context, {required bool isCheckIn}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isCheckIn) {
        checkInTime.value = picked;
      } else {
        checkOutTime.value = picked;
      }
    }
  }

  Future<void> pickDate(BuildContext context, {required bool isCheckIn}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isCheckIn) {
        checkInDate.value = picked;
      } else {
        checkOutDate.value = picked;
      }
    }
  }

  //=============== selected page 2===========
  // current selection
  var selectedPlatform = "Instagram".obs;
  var selectedContentType = "Post".obs;
  var quantity = 1.obs;

  // final list (API payload)
  RxList<Map<String, dynamic>> deliverables = <Map<String, dynamic>>[].obs;

  // platform config
  final List<String> platformNames = ["Instagram", "TikTok", "YouTube", "Facebook", "X (Twitter)"];
  final Map<String, Color> platformColors = {
    "Instagram": const Color(0xFFE1306C),
    "TikTok": Colors.black,
    "YouTube": Colors.red,
    "Facebook": const Color(0xFF1877F2),
    "X (Twitter)": Colors.black,
  };
  final Map<String, IconData> platformIcons = {
    "Instagram": Icons.camera_alt,
    "TikTok": Icons.music_note,
    "YouTube": Icons.play_circle_fill,
    "Facebook": Icons.facebook,
    "X (Twitter)": Icons.alternate_email,
  };

  final List<String> contentTypes = [
    "Post",
    "Reel",
    "Story",
    "Video"
  ];

  // Add or Update deliverable
  void addDeliverable() {
    final index = deliverables.indexWhere(
          (e) =>
      e["platform"] == selectedPlatform.value &&
          e["contentType"] == selectedContentType.value,
    );

    if (index != -1) {
      // update existing quantity
      deliverables[index]["quantity"] += quantity.value;
      deliverables.refresh();
    } else {
      // add new entry
      deliverables.add({
        "platform": selectedPlatform.value,
        "contentType": selectedContentType.value,
        "quantity": quantity.value,
      });
    }

    // reset quantity
    quantity.value = 1;
  }

  //  Remove by index
  void removeDeliverable(int index) {
    deliverables.removeAt(index);
  }

  // Update quantity directly (optional use in list)
  void updateQuantity(int index, int newQty) {
    if (newQty <= 0) {
      deliverables.removeAt(index);
    } else {
      deliverables[index]["quantity"] = newQty;
      deliverables.refresh();
    }
  }

  // Quantity control (selection time)
  void increment() => quantity.value++;

  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }


  // ============= create deals 3rd page ========
  var isNightCredits = false.obs;
  var isDirectPayment = false.obs;
  var totalNights = 0.obs;
  var paymentAmount = 0.0.obs;
  var guestCount = 0.obs;

  // TextEditingController for TextField
  late TextEditingController paymentController;

  @override
  void onInit() {
    super.onInit();
    paymentController = TextEditingController(text: "0.00");

    // listen to TextField changes
    paymentController.addListener(() {
      final text = paymentController.text;
      paymentAmount.value = double.tryParse(text) ?? 0.0;
    });
  }

  // Toggle Compensation Type
  void toggleNightCredits() => isNightCredits.value = !isNightCredits.value;
  void toggleDirectPayment() => isDirectPayment.value = !isDirectPayment.value;

  // Nights Stepper
  void incrementNights() => totalNights.value++;
  void decrementNights() {
    if (totalNights.value > 1) totalNights.value--;
  }
  // Guest count stepper
  void incrementGuest() => guestCount.value++;
  void decrementGuest() {
    if (guestCount.value > 1) guestCount.value--;
  }

  // ================ create deals Controller ==============
  var isCreatingDeal = false.obs;
  Future<void> createDeal() async {
    final body = {
      "title": selectedId.value,
      "description": titleDescriptionController.value.text,
      "addAirbnbLink": selectedAirbnbLink.value,
      "inTimeAndDate": checkInDate.value != null && checkInTime.value != null
          ? DateTime(
        checkInDate.value!.year,
        checkInDate.value!.month,
        checkInDate.value!.day,
        checkInTime.value!.hour,
        checkInTime.value!.minute,
      ).toUtc().toIso8601String()
          : null,
      "outTimeAndDate": checkOutDate.value != null && checkOutTime.value != null
          ? DateTime(
        checkOutDate.value!.year,
        checkOutDate.value!.month,
        checkOutDate.value!.day,
        checkOutTime.value!.hour,
        checkOutTime.value!.minute,
      ).toUtc().toIso8601String()
          : null,
      "compensation": {
        "nightCredits": isNightCredits.value,
        "numberOfNights": totalNights.value,
        "directPayment": isDirectPayment.value,
        "paymentAmount": paymentAmount.value,
      },
      "deliverables": deliverables.map((e) => e).toList(),
      "guestCount": guestCount.value,
    };

    try {
      isCreatingDeal.value = true;
      final response = await ApiClient.postData(ApiUrl.createDeal, jsonEncode(body),);

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Deal created successfully", isError: false,);
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        collaborationController.getSingleUser(userId: id);
        await getDeals(loadMore: false);
        Get.toNamed(AppRoutes.hostHomeScreen);
      } else {
        showCustomSnackBar(
          jsonResponse['error']?.toString() ?? "Failed to create deal",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      isCreatingDeal.value = false;
      debugPrint("Create deal error: $e");
    }
  }

  // ================ Search Deals =================
  RxList<Deal> searchDealList = <Deal>[].obs;
  RxString searchQuery = ''.obs;

  final rxSearchDealStatus = Status.completed.obs;
  void setSearchDealStatus(Status status) => rxSearchDealStatus.value = status;

  Future<void> searchDeals({required String query}) async {
    setSearchDealStatus(Status.loading);
    searchDealList.clear();

    try {
      final response = await ApiClient.getData(ApiUrl.dealSearch(listSearch: query));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final DealResponse model = DealResponse.fromJson(jsonResponse);

        searchDealList.assignAll(model.deals);
        setSearchDealStatus(Status.completed);
      } else {
        setSearchDealStatus(Status.error);
        showCustomSnackBar("Failed to search deals", isError: true);
      }
    } catch (e) {
      setSearchDealStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }


// ================ Get deals Controller ==============
  RxList<Deal> dealList = <Deal>[].obs;

  final isDealLoading = false.obs;
  final isDealLoadMore = false.obs;

  final rxDealStatus = Status.loading.obs;
  void setDealStatus(Status status) => rxDealStatus.value = status;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> getDeals({bool loadMore = false}) async {
    if (loadMore) {
      if (isDealLoadMore.value || currentPage >= totalPages) return;
      isDealLoadMore.value = true;
      currentPage++;
    } else {
      isDealLoading.value = true;
      setDealStatus(Status.loading);
      currentPage = 1;
      dealList.clear();
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getDeals(page: currentPage.toString()),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final DealResponse model = DealResponse.fromJson(jsonResponse);

        totalPages = model.totalPages;

        // Add new items if not duplicate
        final existingIds = dealList.map((e) => e.id).toSet();
        for (final item in model.deals) {
          if (!existingIds.contains(item.id)) {
            dealList.add(item);
          }
        }

        setDealStatus(Status.completed);
      } else {
        setDealStatus(Status.error);
        showCustomSnackBar("Failed to load deals", isError: true);
      }
    } catch (e) {
      setDealStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isDealLoading.value = false;
      isDealLoadMore.value = false;
    }
  }

// ================ Get Single deals function ==============
  RxList<Deal> singleDealList = <Deal>[].obs;

  final rxSingleDealStatus = Status.loading.obs;
  void setSingleDealStatus(Status status) => rxSingleDealStatus.value = status;

  Future<void> singleGetDeal({required String id}) async {
    setSingleDealStatus(Status.loading);
    singleDealList.clear();

    try {
      final response = await ApiClient.getData(ApiUrl.getSingleDeal(id: id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final List dealsJson = jsonResponse['data']['deal'];

        singleDealList.assignAll(
          dealsJson.map((e) => Deal.fromJson(e)).toList(),
        );

        setSingleDealStatus(Status.completed);
      } else {
        setSingleDealStatus(Status.error);
        showCustomSnackBar("Failed to load deal", isError: true);
      }
    } catch (e) {
      setSingleDealStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }


  // ================== UPDATE LISTING ==================

//   Future<void> updateListing({required String listingId}) async {
//     isUpdateListingLoading.value = true;
//     refresh();
//
//     try {
//       final Map<String, String> body = {
//         "title": updateTitleController.value.text.trim(),
//         "description": updateTitleDescriptionController.value.text.trim(),
//         "location": updateLocationController.value.text.trim(),
//         "addAirbnbLink": updateAirbnbController.value.text.trim(),
//         "propertyType": updateSelectedPropertyType.value,
//         "amenities": jsonEncode(updateAmenities),
//         "customAmenities": updateCustomAmenities.join(","),
//
//
// // old images if backend uses them
//         //"existingImages": jsonEncode(updateImageUrls),
//       };
//
//
//       final response = await ApiClient.putMultipartData(ApiUrl.updateListing(id: listingId), body,
//         multipartBody: updateSelectedImages.map((file) => MultipartBody("images", file)).toList(),
//       );
//       isUpdateListingLoading.value = false;
//       refresh();
//
//       final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
//
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         showCustomSnackBar(jsonResponse['message']?.toString() ?? "Listing updated successfully!", isError: false,);
//
//         await getListings(loadMore: false);
//         refresh();
//         Get.back();
//       } else {
//         showCustomSnackBar(jsonResponse['message']?.toString() ?? "Update failed", isError: true,);
//       }
//     } catch (e) {
//       isUpdateListingLoading.value = false;
//       refresh();
//       debugPrint("Update listing error: $e");
//       showCustomSnackBar("An error occurred. Please try again.", isError: true,);
//     }
//   }

  // ============= Delete Listing ==================

  Future<void> deleteDeal({required String id}) async {
    try {

      final response = await ApiClient.deleteData(ApiUrl.deleteDeal(id: id),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Deal deleted successfully");

        showCustomSnackBar("Listing Deal successfully!", isError: false,);
        await getDeals(loadMore: false);
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        collaborationController.getSingleUser(userId: id);
        refresh();
        Get.back();

      } else {
        debugPrint("Failed to Delete Deal");
        showCustomSnackBar("Failed to Delete Deal", isError: true);
      }
    } catch (e) {
      debugPrint("Error Deleting Deal: $e");
      showCustomSnackBar("Something went wrong!", isError: true);
    }
  }

}
