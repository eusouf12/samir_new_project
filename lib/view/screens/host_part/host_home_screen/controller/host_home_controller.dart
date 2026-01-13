import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HostHomeController extends GetxController {
  RxInt selectedTab = 0.obs;
  RxString selectedTabName = "".obs;
  final List<String> tabNames = [ "All", "Active", "Pending", "Completed", "Request",];
  void changeTab(int index) {
    selectedTab.value = index;
    selectedTabName.value = tabNames[index];
    debugPrint("Selected Tab: ${selectedTabName.value}");
  }



  RxInt currentIndex = 0.obs;
  ///============= Collaboration Tab List ==========
  RxList<String> collaborationTabList = <String>['All', 'Pending', 'Approved','Declined'].obs;
}
