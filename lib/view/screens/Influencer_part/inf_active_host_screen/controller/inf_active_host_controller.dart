import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../host_part/host_active_influe/model/all_user_model.dart';

class InfActiveHostController extends GetxController {

  // ================= SEARCH INFLUENCER =================
  RxList<AllUserModel> searchHostList = <AllUserModel>[].obs;
  RxString searchQuery = ''.obs;

  final rxSearchHostStatus = Status.completed.obs;

  void setSearchHostStatus(Status status) => rxSearchHostStatus.value = status;

  Future<void> searchHost({required String query}) async {
    searchQuery.value = query;
    searchHostList.clear();
    setSearchHostStatus(Status.loading);

    try {
      final response = await ApiClient.getData(
          ApiUrl.influencerSearch(query: query));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final List users = jsonResponse['data']?['users'] ?? [];

        searchHostList.assignAll(
          users.map((e) => AllUserModel.fromJson(e)).toList(),);

        setSearchHostStatus(Status.completed);
      } else {
        setSearchHostStatus(Status.error);
        showCustomSnackBar("Failed to search influencers", isError: true);
      }
    } catch (e) {
      setSearchHostStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    }
  }

  // ================= GET INFLUENCER LIST =================
  RxList<AllUserModel> hostList = <AllUserModel>[].obs;

  final isLoading = false.obs;
  final isLoadMore = false.obs;

  final rxStatus = Status.loading.obs;

  void setStatus(Status status) => rxStatus.value = status;

  int currentPage = 1;
  int totalPages = 1;

  Future<void> getActiveHost({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value || currentPage >= totalPages) return;
      isLoadMore.value = true;
      currentPage++;
    } else {
      hostList.clear();
      isLoading.value = true;
      currentPage = 1;
      setStatus(Status.loading);
    }

    try {
      final response = await ApiClient.getData(ApiUrl.hostList(page: currentPage.toString()));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final model = AllUsersResponse.fromJson(jsonResponse);

        totalPages = model.pagination.totalPages;

        // duplicate avoid
        final existingIds = hostList.map((e) => e.id).toSet();

        hostList.addAll(
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
}