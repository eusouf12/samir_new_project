import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../host_part/host_deal_screen/deal_model/deal_model.dart';

class AllDealController extends GetxController {


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

  Future<void> getAllDeals({bool loadMore = false}) async {
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
      final response = await ApiClient.getData(ApiUrl.getAllDeals(page: currentPage.toString()),);

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

}
