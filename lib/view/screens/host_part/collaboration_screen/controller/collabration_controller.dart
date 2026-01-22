import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/collaboration_model.dart';
import '../model/collaboration_single_model.dart';


class CollaborationController extends GetxController {
  RxList<String> collaborationTabList = <String>['All','Pending','Approved','Declined'].obs;
  RxInt currentIndex = 0.obs;

  // Function to call based on tab index
  void onTabSelected(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        getMyCollaborations();
        break;
      case 1:
        getMyCollaborations();
        break;
      case 2:
        getMyCollaborations();
        break;
      case 3:
        getMyCollaborations();
        break;
    }
  }

  // =========== get my collaborations ===========
    RxList<CollaborationModel> collaborationList = <CollaborationModel>[].obs;
    final isCollaborationLoading = false.obs;
    final isCollaborationLoadMore = false.obs;
    final rxCollaborationStatus = Status.loading.obs;
    void setCollaborationStatus(Status status) => rxCollaborationStatus.value = status;

    int currentPage = 1;
    int totalPages = 1;

    Future<void> getMyCollaborations({bool loadMore = false}) async {
      if (loadMore) {
        if (isCollaborationLoadMore.value || currentPage >= totalPages) return;
        isCollaborationLoadMore.value = true;
        currentPage++;
      }
      else {
        collaborationList.clear();
        isCollaborationLoading.value = true;
        currentPage = 1;
        setCollaborationStatus(Status.loading);
      }

      try {
        final response = await ApiClient.getData(ApiUrl.myCollaborations(page: currentPage.toString()));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

          final model = MyCollaborationsResponse.fromJson(jsonResponse);

          totalPages = model.totalPages;
          final existingIds = collaborationList.map((e) => e.id).toSet();

          collaborationList.addAll(model.data.collaborations.where((e) => !existingIds.contains(e.id)),);

          setCollaborationStatus(Status.completed);
        } else {
          setCollaborationStatus(Status.error);
          showCustomSnackBar("Failed to load collaborations", isError: true);
        }
      } catch (e) {
        setCollaborationStatus(Status.error);
        showCustomSnackBar("Error: ${e.toString()}", isError: true);
      } finally {
        isCollaborationLoading.value = false;
        isCollaborationLoadMore.value = false;
      }
    }

    // ============ get single user collaboration =====================
  RxList<SingleUserCollaborationData> singleUserCollaborationList = <SingleUserCollaborationData>[].obs;
  final singleUserCollaborationIsLoading = false.obs;

  final singleUserCollaborationStatus = Status.loading.obs;
  void setSingleUserCollaborationStatus(Status status) => singleUserCollaborationStatus.value = status;

  Future<void> getSingleUserCollaboration({required String id}) async {
    singleUserCollaborationIsLoading.value = true;
    setSingleUserCollaborationStatus(Status.loading);
    singleUserCollaborationList.clear();

    try {
      final response = await ApiClient.getData(ApiUrl.singleInfluencerCollaborations(id: id),);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

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

}
