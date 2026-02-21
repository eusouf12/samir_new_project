import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_listing_screen/widgets/listin_custom_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/listing_controller.dart';

class HostListingScreen extends StatelessWidget {
  HostListingScreen({super.key});

  final ListingController controller = Get.put(ListingController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getListings(loadMore: false);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {controller.getListings(loadMore: true);}
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "My Listings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            //search
            CustomTextField(
              isDens: true,
              fillColor: const Color(0xffF5F5F5),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.textClr),
              prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textClr),
              onChanged: (value) {
                controller.searchQuery.value = value;

                if (value.trim().isEmpty) {
                  controller.searchListingList.clear();
                  controller.setSearchListingStatus(Status.completed);
                } else {
                  controller.searchMyListing(query: value);
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final bool isSearching = controller.searchQuery.value.isNotEmpty;

                // ========= Loader =========
                if (!isSearching && controller.rxListingStatus.value == Status.loading) {
                  return  Center(child: CustomLoader());
                }

                if (isSearching && controller.rxSearchListingStatus.value == Status.loading) {
                  return  Center(child: CustomLoader());
                }

                // ========= Decide list =========
                final listToShow = isSearching ? controller.searchListingList : controller.listingList;

                if (listToShow.isEmpty) {
                  return const Center(
                    child: CustomText(text: "No listings found", fontSize: 16),
                  );
                }

                return
                  ListView.builder(
                  controller: isSearching ? null : scrollController,
                  itemCount: listToShow.length + (!isSearching && controller.isLoadMoreLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < listToShow.length) {
                      final listing = listToShow[index];
                      return ListingCard(
                        listing: listing,
                        staus: listing.status,
                        btn: true,
                        btn2: false,
                        onTapAirbnb: () async {
                          final link = listing.addAirbnbLink;
                          if (link.isEmpty) return;

                          final uri = Uri.parse(link.startsWith('http') ? link : 'https://$link',);
                          await launchUrl(uri, mode: LaunchMode.externalApplication,);
                        },
                        onTapEdit: (){
                          Get.toNamed(AppRoutes.hostUpdateListingScreen,arguments: listing.id);
                        },
                        onTapDelete: (){
                          controller.deleteListing(id: listing.id);
                        },
                      );
                    } else {
                      return  Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CustomLoader()),
                      );
                    }
                  },
                );
              }),
            ),



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.hostAddNewListingScreen);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
