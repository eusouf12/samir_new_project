import 'package:get/get.dart';

import '../../view/screens/Influencer_part/inf_home_screen/controller/inf_home_controller.dart';
import '../../view/screens/host_part/host_home_screen/controller/host_home_controller.dart';
import '../../view/screens/host_part/host_listing_screen/controller/listing_controller.dart';
import '../../view/screens/host_part/host_profile_screen/controller/host_profile_controller.dart';
import '../../view/screens/onboarding_screen/controller/onboarding_controller.dart';
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => HostProfileController(), fenix: true);
    Get.lazyPut(() => HostHomeController(), fenix: true);
    Get.lazyPut(() => InfHomeController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => ListingController(), fenix: true);



  }
}
