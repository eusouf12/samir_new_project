import 'package:get/get.dart';
class InfHomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  ///============= Collaboration Tab List ==========
  RxList<String> collaborationTabList =
      <String>['All', 'Pending', 'Approved','Declined'].obs;
}