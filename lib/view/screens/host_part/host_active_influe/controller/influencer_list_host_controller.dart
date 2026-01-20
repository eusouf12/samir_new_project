import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../host_deal_screen/deal_model/deal_model.dart';
import '../model/all_user_model.dart';

class InfluencerListHostController extends GetxController {

  // ================= SEARCH INFLUENCER =================
  RxList<AllUserModel> searchInfluencerList = <AllUserModel>[].obs;
  RxString searchQuery = ''.obs;

  final rxSearchInfluencerStatus = Status.completed.obs;
  void setSearchInfluencerStatus(Status status) =>
      rxSearchInfluencerStatus.value = status;

  Future<void> searchInfluencer({required String query}) async {
    searchQuery.value = query;
    searchInfluencerList.clear();
    setSearchInfluencerStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.influencerSearch(query: query));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final List users = jsonResponse['data']?['users'] ?? [];

        searchInfluencerList.assignAll(users.map((e) => AllUserModel.fromJson(e)).toList(),);

        setSearchInfluencerStatus(Status.completed);
      } else {
        setSearchInfluencerStatus(Status.error);
        showCustomSnackBar("Failed to search influencers", isError: true);
      }
    } catch (e) {
      setSearchInfluencerStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }

  // ================= GET INFLUENCER LIST =================
  RxList<AllUserModel> influencerList = <AllUserModel>[].obs;

  final isLoading = false.obs;
  final isLoadMore = false.obs;

  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> getInfluencers({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value || currentPage >= totalPages) return;
      isLoadMore.value = true;
      currentPage++;
    } else {
      influencerList.clear();
      isLoading.value = true;
      currentPage = 1;
      setStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.influencerList(page: currentPage.toString()));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = AllUsersResponse.fromJson(jsonResponse);

        totalPages = model.pagination.totalPages;

        // duplicate avoid
        final existingIds = influencerList.map((e) => e.id).toSet();

        influencerList.addAll(
          model.data.where((e) => !existingIds.contains(e.id)),
        );


        setStatus(Status.completed);
      } else {
        setStatus(Status.error);
        showCustomSnackBar("Failed to load influencers", isError: true);
      }
    } catch (e) {
      setStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  //================ create collaboration =================
  RxList<Deal> dealList = <Deal>[].obs;
  RxString selectedDealTitle = ''.obs;
  RxString selectedDealId = ''.obs;

  var isCreatingCollaboration = false.obs;
  Future<void> createCollaboration({required String influencerId}) async {
    final body = {
      "selectInfluencerOrHost": influencerId,
      "selectDeal": selectedDealId.value,
    };

    try {
      isCreatingCollaboration.value = true;
      final response = await ApiClient.postData(ApiUrl.createCollaboration, jsonEncode(body),);

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        selectedDealId.value = '';
        selectedDealTitle.value = '';
        isCreatingCollaboration.value = false;
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Collaboration created successfully", isError: false,);
        Get.back();
      } else {
        showCustomSnackBar(
          jsonResponse['error']?.toString() ?? "Failed to collaboration deal",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      isCreatingCollaboration.value = false;
      debugPrint("Create collaboration error: $e");
    }
  }

  // ================= GET MY COLLABORATIONS =================

}

