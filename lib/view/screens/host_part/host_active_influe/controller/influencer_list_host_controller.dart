import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/screens/host_part/collaboration_screen/controller/collabration_controller.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
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
  final CollaborationController collaborationController = Get.put(CollaborationController());

  final rxSearchInfluencerStatus = Status.completed.obs;
  void setSearchInfluencerStatus(Status status) => rxSearchInfluencerStatus.value = status;

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
  int totaInfluencer = 0;

  Future<void> getInfluencers({bool loadMore = false}) async {
    final role = await SharePrefsHelper.getString(AppConstants.role);

    if (loadMore) {
      if (isLoadMore.value || currentPage >= totalPages) return;
      isLoadMore.value = true;
      currentPage++;
    }
    else {
      influencerList.clear();
      isLoading.value = true;
      currentPage = 1;
      setStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.influencerList(page: currentPage.toString(), role: role=="host" ? "influencer" : "host"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = AllUsersResponse.fromJson(jsonResponse);
        totaInfluencer = model.pagination.totalUsers;
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

  // ========== GetFavourite Inf list ===========
  final isFavouriteLoading = false.obs;
  final isFavouriteLoadMore = false.obs;
  final rxFavouriteStatus = Status.loading.obs;
  void setFavouriteStatus(Status status) => rxFavouriteStatus.value = status;
  int favouriteCurrentPage = 1;
  int favouriteTotalPages = 1;
  int totalFavouriteInfluencer = 0;

  Future<void> getFavouriteInfluencers({bool loadMore = false}) async {

    if (loadMore) {
      if (isFavouriteLoadMore.value || favouriteCurrentPage >= favouriteTotalPages) return;
      isFavouriteLoadMore.value = true;
      favouriteCurrentPage++;
    } else {
      influencerList.clear();
      isFavouriteLoading.value = true;
      favouriteCurrentPage = 1;
      setFavouriteStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.favouriteInfluencerList(page: favouriteCurrentPage.toString(),),);

      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = AllUsersResponse.fromJson(jsonResponse);

        totalFavouriteInfluencer = model.pagination.totalUsers;
        favouriteTotalPages = model.pagination.totalPages;

        final existingIds = influencerList.map((e) => e.id).toSet();

        influencerList.addAll(model.data.where((e) => !existingIds.contains(e.id)),);

        setFavouriteStatus(Status.completed);

      } else {
        setFavouriteStatus(Status.error);
        showCustomSnackBar("Failed to load favourites", isError: true);
      }

    } catch (e) {
      setFavouriteStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isFavouriteLoading.value = false;
      isFavouriteLoadMore.value = false;
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

  //============  Add Inf Favourite ================
  RxBool favouriteLoading = false.obs;
  Future<void> toggleInfFavourite({required String infId}) async {

    final index = influencerList.indexWhere((e) => e.id == infId);

    if (index != -1) {
      final currentUser = influencerList[index];

      influencerList[index] = currentUser.copyWith(
        isFavoritedByMe: !currentUser.isFavoritedByMe,
      );

      influencerList.refresh();
    }

    try {
      dynamic response = await ApiClient.postData(ApiUrl.addFavouriteInf(infId: infId), null,);

      if (response.statusCode != 200 && response.statusCode != 201) {
        getFavouriteInfluencers();
        if (index != -1) {
          final currentUser = influencerList[index];
          influencerList[index] = currentUser.copyWith(isFavoritedByMe: !currentUser.isFavoritedByMe,);
          influencerList.refresh();
        }
        showCustomSnackBar("Failed to update favourite", isError: true);
      }

    } catch (e) {

      if (index != -1) {
        final currentUser = influencerList[index];
        influencerList[index] = currentUser.copyWith(isFavoritedByMe: !currentUser.isFavoritedByMe,);
        influencerList.refresh();
      }

      showCustomSnackBar("An error occurred.", isError: true);
    }
  }

  //remove
  Future<void> removeFavouriteFromList({required String infId}) async {

    final index = influencerList.indexWhere((e) => e.id == infId);
    if (index == -1) return;

    final removedUser = influencerList[index];

    /// UI instantly remove
    influencerList.removeAt(index);
    influencerList.refresh();

    try {

      final response = await ApiClient.postData(ApiUrl.addFavouriteInf(infId: infId), null,);

      if (response.statusCode != 200 && response.statusCode != 201) {
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        collaborationController.getSingleUser(userId: id);
        influencerList.insert(index, removedUser);
        influencerList.refresh();

        showCustomSnackBar("Failed to remove favourite", isError: true,);
      }

    } catch (e) {
      influencerList.insert(index, removedUser);
      influencerList.refresh();

      showCustomSnackBar("Something went wrong", isError: true,);
    }
  }
}

