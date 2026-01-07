import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../host_listing_screen/model/listing_model.dart';

class DealsController extends GetxController {
  RxList<ListingItem> listingList = <ListingItem>[].obs;
  RxString selectedTitle = ''.obs;
  Rx<TextEditingController> titleDescriptionController = TextEditingController().obs;
  // CHECK IN
  Rx<TimeOfDay?> checkInTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> checkInDate = Rx<DateTime?>(null);

  // CHECK OUT
  Rx<TimeOfDay?> checkOutTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);

  String get checkInFormattedTime => checkInTime.value == null ? "Select time" : checkInTime.value!.format(Get.context!);
  String get checkOutFormattedTime => checkOutTime.value == null ? "Select time" : checkOutTime.value!.format(Get.context!);
  String get checkInFormattedDate => checkInDate.value == null ? "Select date" : DateFormat('dd MMM yyyy').format(checkInDate.value!);
  String get checkOutFormattedDate => checkOutDate.value == null ? "Select date" : DateFormat('dd MMM yyyy').format(checkOutDate.value!);

  Future<void> pickTime(BuildContext context, {required bool isCheckIn}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isCheckIn) {
        checkInTime.value = picked;
      } else {
        checkOutTime.value = picked;
      }
    }
  }

  Future<void> pickDate(BuildContext context, {required bool isCheckIn}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isCheckIn) {
        checkInDate.value = picked;
      } else {
        checkOutDate.value = picked;
      }
    }
  }
}
