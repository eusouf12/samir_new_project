import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_check.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../host_active_influe/model/review_model.dart';
import '../model/collaboration_single_model.dart';
import '../model/single_user_model.dart';
import '../views/stripe_web_view_create_screen.dart';
import '../views/stripe_web_view_screen.dart';


class CollaborationController extends GetxController {
  RxList<String> collaborationTabList = <String>['All','Pending','Negotiating','Accepted','Ongoing','Declined','Completed'].obs;
  RxInt currentIndex = 0.obs;

  // Function to call based on tab index
  void onTabSelected(int index) async{
    currentIndex.value = index;
    String id = await SharePrefsHelper.getString(AppConstants.userId);
    switch (index) {
      case 0:
        getSingleUserCollaboration(id: id);
        break;
      case 1:
        getSingleUserCollaboration(id: id,filterName: "pending");
        break;
      case 2:
        getSingleUserCollaboration(id: id,filterName: "negotiating");
        break;
      case 3:
        getSingleUserCollaboration(id: id,filterName: "accepted");
        break;
      case 4:
        getSingleUserCollaboration(id: id,filterName : "ongoing");
        break;
      case 5:
        getSingleUserCollaboration(id: id,filterName : "rejected");
        break;
      case 6:
        getSingleUserCollaboration(id: id,filterName : "completed");
        break;
    }
  }

  // // =========== get my collaborations ===========
  //   RxList<CollaborationModel> collaborationList = <CollaborationModel>[].obs;
  //   final isCollaborationLoading = false.obs;
  //   final isCollaborationLoadMore = false.obs;
  //   final rxCollaborationStatus = Status.loading.obs;
  //   void setCollaborationStatus(Status status) => rxCollaborationStatus.value = status;
  //
  //   int currentPage = 1;
  //   int totalPages = 1;
  //
  //   Future<void> getMyCollaborations({bool loadMore = false}) async {
  //     if (loadMore) {
  //       if (isCollaborationLoadMore.value || currentPage >= totalPages) return;
  //       isCollaborationLoadMore.value = true;
  //       currentPage++;
  //     }
  //     else {
  //       collaborationList.clear();
  //       isCollaborationLoading.value = true;
  //       currentPage = 1;
  //       setCollaborationStatus(Status.loading);
  //     }
  //
  //     try {
  //       final response = await ApiClient.getData(ApiUrl.myCollaborations(page: currentPage.toString()));
  //
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
  //
  //         final widget = MyCollaborationsResponse.fromJson(jsonResponse);
  //
  //         totalPages = widget.totalPages;
  //         final existingIds = collaborationList.map((e) => e.id).toSet();
  //
  //         collaborationList.addAll(widget.data.collaborations.where((e) => !existingIds.contains(e.id)),);
  //
  //         setCollaborationStatus(Status.completed);
  //       } else {
  //         setCollaborationStatus(Status.error);
  //         showCustomSnackBar("Failed to load collaborations", isError: true);
  //       }
  //     } catch (e) {
  //       setCollaborationStatus(Status.error);
  //       showCustomSnackBar("Error: ${e.toString()}", isError: true);
  //     } finally {
  //       isCollaborationLoading.value = false;
  //       isCollaborationLoadMore.value = false;
  //     }
  //   }

    // ============ get single user collaboration =====================
  RxList<SingleUserCollaborationData> singleUserCollaborationList = <SingleUserCollaborationData>[].obs;
  final singleUserCollaborationIsLoading = false.obs;

  final singleUserCollaborationStatus = Status.loading.obs;
  void setSingleUserCollaborationStatus(Status status) => singleUserCollaborationStatus.value = status;

  Future<void> getSingleUserCollaboration({String? filterName,required String id}) async {
    singleUserCollaborationIsLoading.value = true;
    setSingleUserCollaborationStatus(Status.loading);
    singleUserCollaborationList.clear();

    try {
      final response = await ApiClient.getData(ApiUrl.singleInfluencerCollaborations(id: id,filter:filterName));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = SingleUserCollaborationResponse.fromJson(jsonResponse);

        singleUserCollaborationList.assignAll(model.data ?? []);

        setSingleUserCollaborationStatus(Status.completed);
      } else {
        setSingleUserCollaborationStatus(Status.error);
        showCustomSnackBar("Failed to load collaborations", isError: true,);
      }
    } catch (e) {
      setSingleUserCollaborationStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      singleUserCollaborationIsLoading.value = false;
    }
  }

  // =========== get single user profile info ================
  final isGetSingleUserLoading = false.obs;
  final rxGetSingleUserStatus = Status.loading.obs;
  void setGetSingleUserStatus(Status status) => rxGetSingleUserStatus.value = status;
  Rxn<SingleUserProfileData> singleUserProfile = Rxn<SingleUserProfileData>();

  Future<void> getSingleUser({required String userId}) async {
    isGetSingleUserLoading.value = true;
    setGetSingleUserStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.singleUserInfo(id: userId));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = SingleUserProfileResponse.fromJson(jsonResponse);
        singleUserProfile.value = model.data;

        setGetSingleUserStatus(Status.completed);
      } else {
        setGetSingleUserStatus(Status.error);
        showCustomSnackBar("Failed to load user", isError: true);
      }
    } catch (e) {
      setGetSingleUserStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isGetSingleUserLoading.value = false;
    }
  }

 //========== Review ===================
  final isReviewLoading = false.obs;
  final isReviewLoadMore = false.obs;
  final rxReviewStatus = Status.loading.obs;
  void setReviewStatus(Status status) => rxReviewStatus.value = status;
  RxList<ReviewModel> userReviewsList = <ReviewModel>[].obs;
  int currentReviewPage = 1;
  int totalReviewPages = 1;

  Future<void> getUserReviews({required String userId, bool loadMore = false}) async {
    if (loadMore) {
      if (isReviewLoadMore.value || currentReviewPage >= totalReviewPages) return;
      isReviewLoadMore.value = true;
      currentReviewPage++;
    } else {
      userReviewsList.clear();
      isReviewLoading.value = true;
      currentReviewPage = 1;
      setReviewStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getReview(userId: userId, page: currentReviewPage.toString()));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final data = UserReviewResponse.fromJson(jsonResponse);

        // Pagination update
        totalReviewPages = data.data.pagination.totalPages;

        // Avoid duplicates
        final existingIds = userReviewsList.map((e) => e.id).toSet();
        userReviewsList.addAll(
          data.data.reviews.where((e) => !existingIds.contains(e.id)),
        );

        setReviewStatus(Status.completed);
      } else {
        setReviewStatus(Status.error);
        showCustomSnackBar("Failed to load reviews", isError: true);
      }
    } catch (e) {
      setReviewStatus(Status.error);
      showCustomSnackBar("Error fetching reviews: ${e.toString()}", isError: true);
    } finally {
      isReviewLoading.value = false;
      isReviewLoadMore.value = false;
    }
  }

  //============  Accept or Reject ================
  RxBool acceptRejectedLoading = false.obs;
  RxString currentStatus = "".obs;
  Future<void> acceptRejected({required String action,required String userId,required String collabrationId}) async {
    acceptRejectedLoading.value = true;
    refresh();

    try {
      Map<String, String> body = {
        "action":action,
      };

      dynamic response = await ApiClient.patchData(ApiUrl.acceptOrReject(id: collabrationId), jsonEncode(body),);

      acceptRejectedLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newStatus = jsonResponse["data"]?["status"] ?? action;
        currentStatus.value = newStatus;
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Status updated successfully!", isError: false,);
        getSingleUserCollaboration(id: userId);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Status Update failed",
          isError: true,
        );
      }
    } catch (e) {
      acceptRejectedLoading.value = false;
      refresh();
      showCustomSnackBar(
        "An error occurred. Please try again.",
        isError: true,
      );
      debugPrint("Profile update error: $e");
    }
  }

  //=========== update collabration ==============
  RxInt updateNightsColl = 0.obs;
  int maxNightCredits = 0;
  RxInt updateGuestColl = 0.obs;
  RxDouble updatePaymentAmountColl = 0.0.obs;
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  RxMap<String, int> updateDeliverableQtyColl = <String, int>{}.obs;
  final isUpdateCollLoading = false.obs;
  RxList<SingleUserDeliverable> updatedDeliverables = <SingleUserDeliverable>[].obs;

  void incrementNight({required String role}) {
    if (updateNightsColl.value >= maxNightCredits) {
      showCustomSnackBar(role == "host" ? "You have exceeded the night credits available for this influencer." : "You only have $maxNightCredits night credits available.", isError: true);
      return;
    }

    updateNightsColl.value++;
  }
  void decrementNight() {
    if (updateNightsColl.value > 1) {
      updateNightsColl.value--;
    }
  }

  Rx<SingleUserCollaborationData?> selectedCollaboration = Rx<SingleUserCollaborationData?>(null);

  TextEditingController paymentController = TextEditingController();

  void setSelectedCollaboration(String collId) {
    final coll = singleUserCollaborationList.firstWhereOrNull((e) => e.id == collId);

    if (coll == null) return;

    selectedCollaboration.value = coll;

    updateNightsColl.value = coll.compensation?.numberOfNights ?? 1;
    updateGuestColl.value = coll.guestCount ?? 1;
    updatePaymentAmountColl.value = double.tryParse(coll.compensation?.paymentAmount ?? "0") ?? 0.0;


    paymentController.text = updatePaymentAmountColl.value.toString();

    updateDeliverableQtyColl.clear();
    for (var d in coll.deliverables ?? []) {
      final key = "${d.platform}_${d.contentType}";
      updateDeliverableQtyColl[key] = d.quantity ?? 0;
    }
  }
//======= negotiation reason
  Future<void> updateCollabration({required String collId}) async {
    final role = await SharePrefsHelper.getString(AppConstants.role);
    isUpdateCollLoading.value = true;

    try {
      if (reasonController.value.text.trim().isEmpty) {
        showCustomSnackBar("Please write your negotiation reason", isError: true);
        return;
      }

      // ===== Deliverables Build =====
      final List<Map<String, dynamic>> deliverableBody = [];

      for (final d in selectedCollaboration.value?.deliverables ?? []) {
        final key = "${d.platform}_${d.contentType}";

        deliverableBody.add({
          "platform": d.platform,
          "contentType": d.contentType,
          "quantity": updateDeliverableQtyColl[key] ?? d.quantity ?? 1,
        });
      }

      // ===== Request Body =====
      final body = {
        "compensation": {
          "numberOfNights": updateNightsColl.value,
          "paymentAmount": updatePaymentAmountColl.value.toString(),
        },
        "deliverables": deliverableBody,
        "guestCount": updateGuestColl.value,
        "negotiationMessage": reasonController.value.text.trim(),
      };

      final response = await ApiClient.patchData(ApiUrl.updateCollabration(id: collId), jsonEncode(body),);
      final dynamic responseData = response.body;

      final Map<String, dynamic> jsonResponse = responseData is String ? jsonDecode(responseData) : responseData as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {

        if (jsonResponse["data"] == null) {
          throw Exception("Data is null in response");
        }

        final updatedModel = SingleUserCollaborationData.fromJson(jsonResponse["data"]);
        final index = singleUserCollaborationList.indexWhere((e) => e.id == updatedModel.id);

        if (index != -1) {
          singleUserCollaborationList[index] = updatedModel;
          singleUserCollaborationList.refresh();
        }

        selectedCollaboration.value = updatedModel;

        updatedDeliverables.assignAll(updatedModel.deliverables ?? []);

        updatePaymentAmountColl.value = double.tryParse(updatedModel.compensation?.paymentAmount ?? "0") ?? 0.0;

        updateNightsColl.value = updatedModel.compensation?.numberOfNights ?? 1;

        showCustomSnackBar(jsonResponse['message'] ?? "Updated successfully", isError: false,);

        Get.offAllNamed(AppRoutes.hostCollaborationScreen,arguments: role);

      }
      else {
        showCustomSnackBar(jsonResponse['message'] ?? "Update failed", isError: true,);
      }

    } catch (e, stackTrace) {
      print("UPDATE ERROR: $e");
      showCustomSnackBar("Something went wrong", isError: true);
    } finally {
      isUpdateCollLoading.value = false;
    }
  }

// ================== Fetch Collaborations ==================
  final isCollabLoading = false.obs;
  final collabStatus = Status.loading.obs;
  void setCollabStatus(Status status) => collabStatus.value = status;
  RxList<SingleUserCollaborationData> collabList = <SingleUserCollaborationData>[].obs;

  Future<void> fetchCollaborations({required String colId}) async {
    isCollabLoading.value = true;
    setCollabStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.singleCollaborations(colId: colId)) ;

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = SingleUserCollaborationResponse.fromJson(jsonResponse);

        collabList.assignAll(model.data ?? []);

        setCollabStatus(Status.completed);
      } else {
        setCollabStatus(Status.error);
        showCustomSnackBar("Failed to load collaborations", isError: true,);
      }
    } catch (e) {
      setCollabStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isCollabLoading.value = false;
    }
  }

  //================== Submit Link =====================
  RxBool submitLinkLoading = false.obs;
  Future<void> submitLinkColleboration({required String collabrationId, required List<String> urls, required String platform, required String contentType}) async {
    final id = await SharePrefsHelper.getString(AppConstants.userId);
    submitLinkLoading.value = true;
    refresh();

    try {
      final Map<String, dynamic> body = {
        "deliverables": [
          {
            "urls": urls,
            "platform": platform,
            "contentType": contentType,
          }
        ]
      };

      final response = await ApiClient.patchData(ApiUrl.singleCollaborationsUpdate(colId: collabrationId), jsonEncode(body),);

      submitLinkLoading.value = false;
      refresh();

      final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Link submitted successfully!", isError: false,);

        // refresh collaboration data
        fetchCollaborations(colId: collabrationId);
        getSingleUserCollaboration(id: id);

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Submission failed", isError: true,);
      }
    } catch (e) {
      submitLinkLoading.value = false;
      refresh();
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Submit link error: $e");
    }
  }

  // ================== Payment api for host ===============
  RxBool hostPaymentLoading = false.obs;

  Future<void> hostPayment({required String colId}) async {
    hostPaymentLoading.value = true;
    refresh();

    final Map<String, dynamic> body = {"description": "Payment for collaboration",};

    try {
      var response = await ApiClient.postData(ApiUrl.hostPayment(colId: colId), jsonEncode(body),);

      hostPaymentLoading.value = false;
      refresh();
      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final checkoutUrl = jsonResponse["data"]?["checkoutUrl"];

        if (checkoutUrl != null) {
          showCustomSnackBar(jsonResponse['message']?.toString() ?? "Redirecting to payment...", isError: false,);
          Get.to(() => StripeWebViewCreateScreen( checkoutUrl:checkoutUrl,));
        } else {
          showCustomSnackBar("Payment session created but no URL returned.", isError: true);
        }

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Payment session creation failed.", isError: true,);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      hostPaymentLoading.value = false;
      refresh();
      showCustomSnackBar("Something went wrong. Please try again.", isError: true,);
      debugPrint("Host Payment Error: $e");
    }
  }

}

