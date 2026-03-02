import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {

  final RxList<AppNotification> notificationList = <AppNotification>[].obs;

  final isNotificationLoading = false.obs;
  final isNotificationLoadMoreLoading = false.obs;

  final rxNotificationStatus = Status.loading.obs;
  void setNotificationStatus(Status status) => rxNotificationStatus.value = status;

  int currentNotificationPage = 1;
  int totalNotificationPages = 1;

  Future<void> getNotifications({bool loadMore = false}) async {

    if (loadMore) {
      if (isNotificationLoadMoreLoading.value || currentNotificationPage >= totalNotificationPages) return;
      isNotificationLoadMoreLoading.value = true;
      currentNotificationPage++;
    }
    else {
      notificationList.clear();
      isNotificationLoading.value = true;
      setNotificationStatus(Status.loading);
      currentNotificationPage = 1;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getNotification(page: currentNotificationPage.toString()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final NotificationResponse model = NotificationResponse.fromJson(jsonResponse);
        totalNotificationPages = model.data?.pagination?.totalPages ?? 1;

        final newItems = model.data?.notifications ?? [];
        final existingIds = notificationList.map((e) => e.id).toSet();

        for (final item in newItems) {
          if (!existingIds.contains(item.id)) {
            notificationList.add(item);
          }
        }
        setNotificationStatus(Status.completed);

      } else {
        setNotificationStatus(Status.error);
        showCustomSnackBar("Failed to load notifications", isError: true,);
      }

    } catch (e) {
      setNotificationStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isNotificationLoading.value = false;
      isNotificationLoadMoreLoading.value = false;
    }
  }

  //========= realAllNotification =====================
  RxBool readAllLoading = false.obs;

  Future<void> readAllNotification() async {
    readAllLoading.value = true;
    refresh();

    try {
      final body = jsonEncode({
        "isRead": true,
      });
      final response = await ApiClient.patchData(ApiUrl.realAllNotification,body,);
      readAllLoading.value = false;
      refresh();

      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        getNotifications(loadMore: false);
        notificationList.value = notificationList.map((item) => item.copyWith(isRead: true)).toList();

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "All notifications marked as read", isError: false,);

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Failed to mark notifications", isError: true,);
      }

    } catch (e) {
      readAllLoading.value = false;
      refresh();
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Read all error: $e");
    }
  }

  RxBool readSingleLoading = false.obs;

  Future<void> singleReadNotification({required String id}) async {
    readSingleLoading.value = true;
    refresh();

    try {
      final body = jsonEncode({
        "isRead": true,
      });
      final response = await ApiClient.patchData(ApiUrl.readSingleNotification(id: id),body,);
      readSingleLoading.value = false;
      refresh();

      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        getNotifications(loadMore: false);
        notificationList.value = notificationList.map((item) {if (item.id == id) {return item.copyWith(isRead: true);}return item;}).toList();

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Single notifications marked as read", isError: false,);

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Failed to mark notifications", isError: true,);
      }

    } catch (e) {
      readSingleLoading.value = false;
      refresh();
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Read Single error: $e");
    }
  }

}