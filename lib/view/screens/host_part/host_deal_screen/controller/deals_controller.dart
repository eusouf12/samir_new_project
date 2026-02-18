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
  var quantity = 0.obs;
  var minFollowers = ''.obs;
// platform wise followers list
  RxMap<String, String> platformFollowers = <String, String>{}.obs;
  Rx<TextEditingController> minFollowersController = TextEditingController().obs;
  void addMinFollowers() {
    if (minFollowers.value.trim().isEmpty) return;

    platformFollowers[selectedPlatform.value] = minFollowers.value.trim();

    debugPrint("AFTER ADD FOLLOWERS: $platformFollowers");

    minFollowers.value = '';
    minFollowersController.value.clear();
  }

  // Social Media payload
  RxList<Map<String, dynamic>> deliverables = <Map<String, dynamic>>[].obs;
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
    if (quantity.value <= 0) return;

    final follower = platformFollowers[selectedPlatform.value];

    if (follower == null) {
      showCustomSnackBar(
        "Please add minimum followers for ${selectedPlatform.value}",
        isError: true,
      );
      return;
    }

    final index = deliverables.indexWhere(
          (e) =>
      e["platform"] == selectedPlatform.value &&
          e["contentType"] == selectedContentType.value,
    );

    final followerMap = {
      selectedPlatform.value: follower,
    };

    if (index != -1) {
      deliverables[index]["quantity"] += quantity.value;
      deliverables[index]["platformFollowers"] = followerMap;
      deliverables.refresh();
    } else {
      deliverables.add({
        "platform": selectedPlatform.value,
        "contentType": selectedContentType.value,
        "quantity": quantity.value,
        "platformFollowers": followerMap,
      });
    }

    quantity.value = 0;
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

  // Nights count
  void incrementNights() => totalNights.value++;
  void decrementNights() {
    if (totalNights.value > 1) totalNights.value--;
  }
  // Guest count stepper
  void incrementGuest() => guestCount.value++;
  void decrementGuest() {
    if (guestCount.value > 0) guestCount.value--;
  }

  // ================ create deals Controller ==============
  var isCreatingDeal = false.obs;
  Future<void> createDeal({required String pageName, String? dealId}) async {
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
      ).toUtc().toIso8601String() : null,
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
      final response = await ApiClient.postData(pageName == "deal" ? ApiUrl.createDeal : ApiUrl.sendCollaboration(id: dealId ?? ""), jsonEncode(body),);

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Deal created successfully", isError: false,);
        resetForm();
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        collaborationController.getSingleUser(userId: id);
        await getDeals(loadMore: false);
        isCreatingDeal.value = false;
        Get.toNamed(AppRoutes.hostHomeScreen);
      }
      else {
        showCustomSnackBar(jsonResponse['error']?.toString() ?? "Failed to create deal", isError: true,);
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      isCreatingDeal.value = false;
      debugPrint("Create deal error: $e");
    }
    finally {
      isCreatingDeal.value = false;
    }
  }


  void resetForm() {
    // page 1
    selectedTitle.value = '';
    selectedId.value = '';
    selectedAirbnbLink.value = '';
    titleDescriptionController.value.clear();

    checkInTime.value = null;
    checkInDate.value = null;
    checkOutTime.value = null;
    checkOutDate.value = null;

    // page 2
    selectedPlatform.value = "Instagram";
    selectedContentType.value = "Post";
    quantity.value = 0;
    minFollowers.value = '';
    minFollowersController.value.clear();
    platformFollowers.clear();
    deliverables.clear();

    // page 3
    isNightCredits.value = false;
    isDirectPayment.value = false;
    totalNights.value = 0;
    paymentAmount.value = 0.0;
    guestCount.value = 0;
    paymentController.text = "0.00";
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
        final deals = dealsJson.map((e) => Deal.fromJson(e)).toList();
        singleDealList.assignAll(deals);

        if (deals.isNotEmpty) {
          final deal = deals.first;
          updateNights.value = deal.compensation.numberOfNights;
          updateGuest.value = deal.guestCount;
          updateNightCredits.value = deal.compensation.nightCredits;
          updateDirectPayment.value = deal.compensation.directPayment;
          updatePaymentAmount.value = double.tryParse(deal.compensation.paymentAmount.toString(),) ?? 0.0;
          updatePlatformFollowers.clear();
          for (final d in deal.deliverables) {
            if (d.platformFollowers.isNotEmpty) {
              updatePlatformFollowers.addAll(d.platformFollowers);
            }
          }
          updateDeliverableQty.clear();
          for (final d in deal.deliverables) {
            final key = "${d.platform}_${d.contentType}";
            updateDeliverableQty[key] = d.quantity;
          }
        }

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
  RxBool updateNightCredits = false.obs;
  RxBool updateDirectPayment = false.obs;
  RxInt updateNights = 1.obs;
  RxInt updateGuest = 1.obs;
  RxDouble updatePaymentAmount = 0.0.obs;
  RxMap<String, String> updatePlatformFollowers = <String, String>{}.obs;
  RxMap<String, int> updateDeliverableQty = <String, int>{}.obs;
  final isUpdateListingLoading = false.obs;

  Future<void> updateDeal({required String dealId}) async {
    isUpdateListingLoading.value = true;
    refresh();

    try {
      final List<Map<String, dynamic>> updatedDeliverables = [];
      final deal = singleDealList.first;
      for (final d in deal.deliverables) {final key = "${d.platform}_${d.contentType}";

        updatedDeliverables.add({
          "platform": d.platform,
          "contentType": d.contentType,
          "quantity": updateDeliverableQty[key] ?? d.quantity,
          "platformFollowers": updatePlatformFollowers.containsKey(d.platform) ? {d.platform: updatePlatformFollowers[d.platform]} : {},
        });
      }
      // body
      final Map<String, dynamic> body = {
        "compensation": {
          "nightCredits": updateNightCredits.value,
          "directPayment": updateDirectPayment.value,
          "numberOfNights": updateNights.value,
          "paymentAmount": updatePaymentAmount.value,
        },
        "deliverables": updatedDeliverables,
        "guestCount": updateGuest.value,
      };


      debugPrint("UPDATE DEAL BODY => ${jsonEncode(body)}");


      final response = await ApiClient.patchData(ApiUrl.updateDeal(id: dealId), jsonEncode(body),);
      isUpdateListingLoading.value = false;
      refresh();
      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message'] ?? "Deal updated successfully", isError: false,);

        await singleGetDeal(id: dealId);
        getDeals();
        Get.back();
      }
      else {
        showCustomSnackBar(jsonResponse['message'] ?? "Update failed", isError: true,);
      }
    } catch (e) {
      isUpdateListingLoading.value = false;
      refresh();
      debugPrint("Update deal error: $e");
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
    }
  }

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
