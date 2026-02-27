import 'dart:convert';

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

}