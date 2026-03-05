import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_nav_bar/inf_navbar.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../host_part/host_listing_screen/controller/listing_controller.dart';
import '../../host_part/host_listing_screen/widgets/listin_custom_card.dart';


class InfExploreDealsScreen extends StatelessWidget {
  InfExploreDealsScreen({super.key});

  final ListingController controller = Get.put(ListingController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getVerifiedAllListings(loadMore: false);
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {controller.getVerifiedAllListings(loadMore: true);}
    });

    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: false,
          titleName: "Explore Listing",
          //rightIcon: AppIcons.favourite,
          rightOnTap: () {
           // Get.toNamed(AppRoutes.infActiveHostsScreen);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              //======= Search ===========
              CustomTextField(
                isDens: true,
                fillColor: const Color(0xffF5F5F5),
                fieldFocusBorderColor: AppColors.primary2,
                hintText: "Search by Country, City & Listing Name",
                hintStyle: TextStyle(color: AppColors.textClr),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textClr,),
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
                  if (!isSearching && controller.rxVerifiedAllListingStatus.value == Status.loading) {
                    return Center(child: CustomLoader(color: AppColors.primary2));
                  }

                  if (isSearching && controller.rxSearchListingStatus.value == Status.loading) {
                    return Center(child: CustomLoader(color: AppColors.primary2,));
                  }

                  final listToShow = isSearching ? controller.searchListingList : controller.verifiedAllListingList;

                  if (listToShow.isEmpty) {
                    return const Center(child: CustomText(text: "No listings found", fontSize: 16,),);
                  }

                  return ListView.builder(
                    controller:
                    isSearching ? null : scrollController,
                    itemCount: listToShow.length + (!isSearching && controller.isVerifiedAllLoadMoreLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < listToShow.length) {
                        final listing = listToShow[index];

                        return ListingCard(
                          listing: listing,
                          staus: listing.status,
                          btn: false,
                          btn2: false,
                          isFavourite:listing.isFavorite,
                          onTapAirbnb: () async {
                            final link = listing.addAirbnbLink;
                            if (link.isEmpty) return;

                            final uri = Uri.parse(link.startsWith('http') ? link : 'https://$link');

                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          },
                          onTapEdit: () {
                            Get.toNamed(AppRoutes.hostUpdateListingScreen, arguments: listing.id,);
                          },
                          onTapDelete: () {
                            controller.deleteListing(id: listing.id);
                          },
                          onTapFavourite: (){
                            controller.toggleHostListingFavourite(listingId: listing.id);
                          },
                        );
                      } else {
                        return Padding(padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CustomLoader(color: AppColors.primary2)),
                        );
                      }
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: InfNavbar(currentIndex: 2),
      ),
    );
  }
}
