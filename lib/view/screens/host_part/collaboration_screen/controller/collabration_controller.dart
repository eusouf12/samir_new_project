import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../host_active_influe/model/review_model.dart';
import '../model/collaboration_single_model.dart';
import '../model/single_user_model.dart';


class CollaborationController extends GetxController {
  RxList<String> collaborationTabList = <String>['All','Pending','Ongoing','Declined'].obs;
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
        getSingleUserCollaboration(id: id,filterName : "ongoing");
        break;
      case 3:
        getSingleUserCollaboration(id: id,filterName : "rejected");
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

  // =========== get single user profile info ================
  final isGetSingleUserLoading = false.obs;
  final rxGetSingleUserStatus = Status.loading.obs;
  void setGetSingleUserStatus(Status status) => rxGetSingleUserStatus.value = status;
  // SingleUserProfileData? singleUserProfile;
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

  // ==================== Reviews List ====================
  RxList<ReviewModel> userReviewsList = <ReviewModel>[].obs;

  // Pagination
  int currentReviewPage = 1;
  int totalReviewPages = 1;

  // ==================== Fetch Reviews ====================
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
}

