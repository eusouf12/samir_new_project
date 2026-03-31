import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../model/calender_model.dart';

class CalenderController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<String> selectedTimes = <String>[].obs;

  void changeDate(DateTime? date) {
    selectedDate.value = date;
  }

  String get formattedSelectedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('yyyy-MM-dd').format(selectedDate.value!.toLocal());
  }

  void toggleTime(String time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time);
    } else {
      selectedTimes.add(time);
    }
    debugPrint("Selected times: $selectedTimes");
  }

  void clearSelection() {
    selectedDate.value = null;
    selectedTimes.clear();
  }

  // ======== getCalendar =============
  final RxMap<DateTime, List<CalendarEntry>> eventMap = <DateTime, List<CalendarEntry>>{}.obs;
  final RxList<CalendarEntry> calendarList = <CalendarEntry>[].obs;
  final isCalendarLoading = false.obs;

  Future<void> getCalendar() async {
    calendarList.clear();
    isCalendarLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrl.getCalenderDate);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final CalendarResponse model = CalendarResponse.fromJson(jsonResponse);

        calendarList.assignAll(model.data ?? []);
        eventMap.clear();

        for (var item in calendarList) {
          if (item.startDate != null && item.endDate != null) {

            DateTime start = DateTime.parse(item.startDate!);
            DateTime end = DateTime.parse(item.endDate!);

            DateTime current = start;

            while (!current.isAfter(end)) {

              final normalizedDate =
              DateTime(current.year, current.month, current.day);

              if (eventMap.containsKey(normalizedDate)) {
                eventMap[normalizedDate]!.add(item);
              } else {
                eventMap[normalizedDate] = [item];
              }

              current = current.add(const Duration(days: 1));
            }
          }
        }

        eventMap.refresh();
      } else {
        showCustomSnackBar("Failed to load calendar", isError: true,);
      }
    } catch (e) {
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
      debugPrint("Calendar error: $e");
    } finally {
      isCalendarLoading.value = false;
    }
  }

  // ========== set calender date ==========
  RxBool isCreateCalendarLoading = false.obs;

  Future<void> createCalendar({required String startDate, required String endDate, required String startTime, required String endTime, required String country, required String city,  String? fullAddress}) async {

    if (startDate.trim().isEmpty) {
      showCustomSnackBar("Start date is required", isError: true);
      return;
    }

    if (endDate.trim().isEmpty) {
      showCustomSnackBar("End date is required", isError: true);
      return;
    }

    if (startTime.trim().isEmpty) {
      showCustomSnackBar("Start time is required", isError: true);
      return;
    }

    if (endTime.trim().isEmpty) {
      showCustomSnackBar("End time is required", isError: true);
      return;
    }

    if (country.trim().isEmpty) {
      showCustomSnackBar("Country is required", isError: true);
      return;
    }

    if (city.trim().isEmpty) {
      showCustomSnackBar("City is required", isError: true);
      return;
    }
    isCreateCalendarLoading.value = true;
    refresh();

    final Map<String, dynamic> body = {
      "startDate": startDate,
      "endDate": endDate,
      "startTime": startTime,
      "endTime": endTime,
      "country": country,
      "city": city,
      "fullAddress": fullAddress,
    };

    try {

      final response = await ApiClient.postData(ApiUrl.createCalendar, jsonEncode(body),);

      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        selectedDate.value = null;
        selectedTimes.clear();
        await getCalendar();
        Get.back();
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Calendar entry created successfully", isError: false,);

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Failed to create calendar entry", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Create calendar error: $e");
    } finally {
      isCreateCalendarLoading.value = false;
      refresh();
    }
  }

  // ===========update =================
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final fullAddressController = TextEditingController();

  void setUpdateData(CalendarEntry item) {
    startDateController.text = item.startDate ?? "";
    endDateController.text = item.endDate ?? "";
    startTimeController.text = item.startTime ?? "";
    endTimeController.text = item.endTime ?? "";
    countryController.text = item.country ?? "";
    cityController.text = item.city ?? "";
    fullAddressController.text = item.fullAddress ?? "";
  }
  void clearUpdateFields() {
    startDateController.clear();
    endDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    countryController.clear();
    cityController.clear();
    fullAddressController.clear();
  }
  RxBool isUpdateCalendarLoading = false.obs;
  Future<void> updateCalendar({required String id}) async {


    isUpdateCalendarLoading.value = true;
    refresh();

    final body = {
      "startDate": startDateController.text.trim(),
      "endDate": endDateController.text.trim(),
      "startTime": startTimeController.text.trim(),
      "endTime": endTimeController.text.trim(),
      "country": countryController.text.trim(),
      "city": cityController.text.trim(),
    };

    try {

      final response = await ApiClient.patchData(ApiUrl.updateCalendar(id: id), jsonEncode(body),);

      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        selectedDate.value = null;
        selectedTimes.clear();

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Calendar updated successfully", isError: false,);
        await getCalendar();
        Get.back();

      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Failed to update calendar", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar("Something went wrong. Try again.", isError: true,);
      debugPrint("Update calendar error: $e");
    } finally {
      isUpdateCalendarLoading.value = false;
      refresh();
    }
  }

}
